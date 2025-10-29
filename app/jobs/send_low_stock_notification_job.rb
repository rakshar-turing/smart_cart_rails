class SendLowStockNotificationJob < ApplicationJob
  queue_as :default

  # We re-notify only if last notification is older than `renotify_after` (default: 1 day)
  def perform(product_id)
    product = Product.find(product_id)

    # Send email
    InventoryMailer.low_stock_alert(product, ['admin@example.com']).deliver_now

    # Optional webhook integration
    if product.webhook_url.present?
      uri = URI(product.webhook_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      req = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })
      req.body = { product: product.name, stock: product.stock }.to_json
      http.request(req)
    end

    product.update!(notified: true)
  end

  private

  def notify_webhook(url, product)
    payload = {
      text: I18n.t("inventory.low_stock_slack_message", name: product.name, stock: product.stock, id: product.id)
    }.to_json

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == "https"
    req = Net::HTTP::Post.new(uri.request_uri, { 'Content-Type' => 'application/json' })
    req.body = payload
    http.request(req)
  rescue => e
    Rails.logger.error("Slack webhook notify failed: #{e.class} #{e.message}")
  end
end
