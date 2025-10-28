# spec/policies/product_policy_spec.rb
require 'rails_helper'

RSpec.describe ProductPolicy do
  let(:admin)    { build(:user, :admin) }
  let(:manager)  { build(:user, :manager) }
  let(:customer) { build(:user, :customer) }
  let(:product)  { build(:product) }

  shared_examples 'grants access to admin and manager only' do |action|
    permissions action do
      it "permits admin for #{action}" do
        expect(subject).to permit(admin, product)
      end

      it "permits manager for #{action}" do
        expect(subject).to permit(manager, product)
      end

      it "denies customer for #{action}" do
        expect(subject).not_to permit(customer, product)
      end
    end
  end

  describe ProductPolicy do
    subject { described_class }

    include_examples 'grants access to admin and manager only', :new?
    include_examples 'grants access to admin and manager only', :create?
    include_examples 'grants access to admin and manager only', :edit?
    include_examples 'grants access to admin and manager only', :update?
  end
end
