require 'test_helper'
require "test/unit/assertions"
include Test::Unit::Assertions

class OrderTest < ActiveSupport::TestCase

  def test_create_order
    Queenbee.api_base = "http://localhost:3000/api"
    response = Queenbee::Order.create({ date: Time.now,
                                        currency: "cad",
                                        client_email: "client@email.com",
                                        amount: "15",
                                        total_price: "15",
                                        city: "Nancy",
                                        country: "France",
                                        shipping: 0,
                                        uid: SecureRandom.hex(4),
                                        source: 'Stripe payment form' } ,111
    )
    puts("response code #{response.inspect}")
    assert_equal "201", response.code
  end

  def test_update_order
    response1 = Queenbee::Order.create({ date: "2014-07-01 14:50:28",
        currency: "CAD", city: "Paris",
        country: "Canada", client_email: "dww@email.com",
        uid: "0000090" }, 111)
    response =  Queenbee::Order.save({ date: "2014-07-01 14:50:28",
        currency: "CAD", city: "Paris",
        country: "Canada", client_email: "kk@email.com",
        uid: "0000090" } ,111)
    assert_equal "200", response.code
  end
end
