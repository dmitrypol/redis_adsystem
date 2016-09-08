class User < ApplicationRecord
  rolify
  include Clearance::User
end
