# encoding: utf-8

puts "GENERATING SAMPLE DATA ..."

3.times do |i|
  x = i + 1
  Application.create!(
    name: "app#{x}",
    slug: "app#{x}",
    active: [true, false].sample
  )
end
puts "created applications..."


orders = []
9500.times do |i|
  x = i + 1
  orders << Order.new(uid: "#{x}",
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
                      products_count: (1..10).to_a.sample,
                      application_id: Application.all.map(&:id).sample
                     )
end
Order.import orders
puts "created orders..."

puts "All set"