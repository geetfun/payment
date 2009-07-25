require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  should_have_many :payment_transactions
  
  context "AASM states" do
    setup do
      @order = Order.new
    end
    
    should "have initial state of pending" do
      assert_equal @order.state, "pending"
    end
  end
end
