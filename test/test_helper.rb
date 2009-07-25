ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'rubygems'
require 'mocha'

class ActiveSupport::TestCase
  
  include ActiveMerchant::Billing
  

  # Testing for database logic
  def test_for_db_error(error_message, &block)
   begin
     yield
   rescue ActiveRecord::StatementInvalid => e
     # rescuing from AR::SI means that it was the SQL server that returned the error
     database_threw_error = true
   rescue StandardError => e
     # this catch all rescue means something else threw error
     something_else_threw_error = true
   end
   assert !something_else_threw_error, "There is an error in our test code; Message: #{e}"
   assert database_threw_error && !something_else_threw_error, "#{error_message}; Message: #{e}"
  end

end
