# == Schema Information
# Schema version: 20090724223200
#
# Table name: payment_transactions
#
#  id         :integer(4)      not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  amount     :integer(4)
#  success    :boolean(1)
#  reference  :string(255)
#  message    :string(255)
#  action     :string(255)
#  params     :text
#  test       :boolean(1)
#  order_id   :integer(4)
#

class PaymentTransaction < ActiveRecord::Base
  public
    serialize :params
    cattr_accessor :gateway
    
  # *********************************************************************************************************************
  # ~ Active Merchant
  # *********************************************************************************************************************
  public
    class << self 
      def authorize(amount, credit_card, options = {}) 
        process('authorization', amount) do |gw| 
          gw.authorize(amount, credit_card, options) 
        end 
      end 

      def capture(amount, authorization, options = {}) 
        process('capture', amount) do |gw| 
          gw.capture(amount, authorization, options) 
        end 
      end
      
      # TODO
      # def purchase
      # end
      # 
      # def void
      # end
      # 
      # def credit
      # end

      private 

      def process(action, amount = nil) 
        result = OrderTransaction.new 
        result.amount = amount 
        result.action = action 

        begin 
          response = yield gateway 

          result.success   = response.success? 
          result.reference = response.authorization 
          result.message   = response.message 
          result.params    = response.params 
          result.test      = response.test?
        rescue ActiveMerchant::ActiveMerchantError => e 
          result.success   = false 
          result.reference = nil 
          result.message   = e.message 
          result.params    = {} 
          result.test      = gateway.test? 
        end 

        result 
      end 
    end 
      

end
