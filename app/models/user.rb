class User < ActiveRecord::Base
  include Clearance::User
  
  has_many :feeds, :dependent => :destroy
  
  validates_presence_of :first_name, :last_name
  
end
