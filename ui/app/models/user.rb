class User < ApplicationRecord
  rolify
  include Clearance::User

  def name
    email
  end

end
