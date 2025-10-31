# app/models/smart_cart_catalog.rb
class SmartCartCatalog
  def self.replacement_for(product_name)
    {
      "Phone" => "Phone X",
      "Laptop" => "Laptop Pro"
    }[product_name]
  end

  def self.latest_version_for(product_name)
    {
      "Phone X" => "2.0",
      "Laptop Pro" => "3.1"
    }[product_name] || "1.0"
  end
end
