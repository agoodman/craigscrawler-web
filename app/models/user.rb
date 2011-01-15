class User < ActiveRecord::Base
  include Clearance::User
  
  has_many :feeds, :dependent => :destroy
  
end
