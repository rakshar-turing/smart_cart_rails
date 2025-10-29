class SharedCartSerializer < ActiveModel::Serializer
  attributes :token, :expires_at
  has_one :cart
end