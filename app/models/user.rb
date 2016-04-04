require 'bcrypt'

class User < ActiveRecord::Base
  # storing encrypted password in self.encrypted_password
  include BCrypt

  def password
    Password.new(encrypted_password)
  end

  def password=(new_password)
    self.encrypted_password = Password.create(new_password)
  end
end
