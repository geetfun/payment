class ChangePaymentTransaction < ActiveRecord::Migration
  def self.up
    add_column :payment_transactions, :amount, :integer
    add_column :payment_transactions, :success, :boolean
    add_column :payment_transactions, :reference, :string
    add_column :payment_transactions, :message, :string
    add_column :payment_transactions, :action, :string
    add_column :payment_transactions, :params, :text
    add_column :payment_transactions, :test, :boolean
    remove_column :payment_transactions, :note 
  end

  def self.down
  end
end
