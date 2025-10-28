require 'rails_helper'

RSpec.describe SendLowStockNotificationJob, type: :job do
  let!(:admin) { create(:user, :admin, email: Faker::Internet.unique.email) }
  let!(:product) { create(:product, stock: 2, low_stock_threshold: 5) }

  before { ActionMailer::Base.deliveries.clear }

  it "sends inventory mail and marks product notified" do
    expect {
      described_class.perform_now(product.id)
    }.to change { ActionMailer::Base.deliveries.count }.by_at_least(1)

    expect(product.reload.notified).to be_present
  end

  it "posts to webhook when URL present" do
    product = create(:product, stock: 3, webhook_url: "https://hooks.slack.com/test")
    stub_request(:post, product.webhook_url).to_return(status: 200, body: "ok")
    described_class.perform_now(product.id)
    expect(WebMock).to have_requested(:post, product.webhook_url).once
  end
end
