class InventoryMailer < ApplicationMailer
  default from: 'no-reply@smartcart.com'

  def low_stock_alert(product, recipients)
    @product = product
    mail(
      to: recipients,
      subject: "Low Stock Alert: #{@product.name}"
    )
  end
end
