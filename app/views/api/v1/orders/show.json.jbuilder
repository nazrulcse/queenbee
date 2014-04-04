json.cache!(@order) do
  json.extract! @order, :id, :uid, :client_email, :country, :city, :products_count,
                        :date, :currency, :amount, :shipping, :total_price, :gift,
                        :coupon, :coupon_code, :url
end