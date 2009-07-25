class RemoveStatusFromTransaction < ActiveRecord::Migration
  def self.up
    remove_column :payment_transactions, :status
  end

  def self.down
  end
end
