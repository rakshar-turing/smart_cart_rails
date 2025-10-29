require "rails_helper"

RSpec.describe InventoryMailer, type: :mailer do
  let(:product) { create(:product, name: "Widget", stock: 2, low_stock_threshold: 5) }
  let(:admin) { create(:user, :admin) }

  it "renders the headers and body" do
    mail = InventoryMailer.low_stock_alert(product, admin.email)
    expect(mail.subject).to include("Low Stock Alert")
    expect(mail.to).to include(admin.email)
    expect(mail.body.encoded).to match /Low Stock Alert/
    expect(mail.body.encoded).to include(product.name)
  end
end
