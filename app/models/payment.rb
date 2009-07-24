# == Schema Information
# Schema version: 20090723223600
#
# Table name: payments
#
#  id         :integer         not null, primary key
#  note       :string(255)
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Payment < ActiveRecord::Base
  
  # *********************************************************************************************************************
  # ~ AASM
  # *********************************************************************************************************************
  public
    include AASM
    
    aasm_column :status
    aasm_initial_state :pending
    
    aasm_state :pending
    aasm_state :failure
    aasm_state :success
    
    aasm_event :paid do
      transitions :to => :success, :from => [:pending, :failure]
    end
    
    aasm_event :not_paid do
      transitions :to => :failure, :from => [:pending]
    end
  
end
