# encoding: utf-8
# require 'faker'

puts "GENERATING SAMPLE DATA ..."

#PgSearch.disable_multisearch do
  orders = []
  9500.times do |i|
    x = i + 1
    orders << Order.new(uid: "#{x}",
                        source: ['bento', 'bonbecs', 'patchwork', 'timehub'].sample,
                        date: Time.now,
                        currency: ['cad', 'eur', 'usd', 'aud', 'jpy'].sample,
                        amount: ['5', '10', '12.25', '3.33', '54.78', '49.03', '21.66', '7.4'].sample,
                        shipping: ['5', '10', '12.25', '3.33', '54.78', '49.03', '21.66', '7.4'].sample,
                        total_price: ['5', '10', '12.25', '3.33', '54.78', '49.03', '21.66', '7.4'].sample,
                        gift: [true, false].sample,
                        coupon: [true, false].sample,
                        coupon_code: ['CHRISTMAS', 'SPRING', '', '', '', 'SUMMER', 'WINTER'].sample,
                        country: ['France', 'Canada', 'Vietnam', 'Ukraine', 'Belgique', 'Japon'].sample,
                        city: ['Paris', 'Monaco', 'Troyes', 'Nancy', 'Lyon', 'Valcourt', 'Tokyo'].sample,
                        url: "http://domain.com/orders/#{x}",
                        client_email: "client#{i}@email.com",
                        products_count: (1..10).to_a.sample
                       )
  end
  Order.import orders
#end

puts "All set"