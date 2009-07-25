# == Schema Information
# Schema version: 20090724223009
#
# Table name: orders
#
#  id          :integer(4)      not null, primary key
#  description :string(255)
#  amount      :integer(4)
#  state       :string(255)     default("pending"), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Order < ActiveRecord::Base
  
  # *********************************************************************************************************************
  # ~ Transactions
  # *********************************************************************************************************************
  public
    # Associations
    has_many :payment_transactions
    
  # *********************************************************************************************************************
  # ~ AASM
  # *********************************************************************************************************************
  public
    include AASM
    
    aasm_column :state
    aasm_initial_state :pending
    
    aasm_state :pending
    aasm_state :capture_authorized
    aasm_state :paid
    aasm_state :payment_declined
    aasm_state :capture_declined
    aasm_state :refunded
    aasm_state :partial_refunded
    
    # Successful capture
    aasm_event :payment_captured do
      transitions :to => :capture_authorized, :from => [:pending, :capture_declined, :payment_declined]
    end
    
    # Successful payment
    aasm_event :payment_authorized do
      transitions :to => :paid, :from => [:pending, :capture_authorized, :payment_declined, :capture_declined, :refunded, :partial_refunded]
    end
    
    # Partial refund from paid
    aasm_event :payment_partial_refunded do
      transitions :to => :partial_refunded, :from => [:paid]
    end
    
    # Full refund from paid or partial refund
    aasm_event :payment_fully_refunded do
      transitions :to => :refunded, :from => [:paid, :partial_refunded]
    end
    
    # Failed capture
    aasm_event :declined_capture do
      transitions :to => :capture_declined, :from => [:pending]
    end
    
    # Failed payment
    aasm_event :declined_payment do
      transitions :to => :payment_declined, :from => [:pending, :capture_authorized, :capture_declined]
    end
  
    # Failed refund
    aasm_event :declined_refund do
      transitions :to => :refund_declined, :from => [:paid, :partial_refund]
    end
end
