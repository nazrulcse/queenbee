json.cache!(@orders) do |order|
  json.extract! order, :id, :uid, :client_email, :country, :city, :products_count, :date, :currency, :amount, :shipping, :total_price, :fees, :gift, :coupon, :coupon_code, :url, :referral, :subscribed_at, :unsubscribed_at
end
