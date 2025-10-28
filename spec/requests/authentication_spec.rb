require 'rails_helper'

RSpec.describe "User Authentication", type: :request do
  let(:user) { create(:user, email: 'test@example.com', password: 'password') }

  it "signs in successfully" do
    post user_session_path, params: {
      user: { email: user.email, password: 'password' }
    }
    expect(response).to have_http_status(:see_other)
  end
end
