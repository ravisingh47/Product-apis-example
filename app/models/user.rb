require 'bcrypt'

class User < ActiveRecord::Base
  # storing encrypted password in self.encrypted_password
  include BCrypt

  before_create :generate_auth_token

  def password
    Password.new(encrypted_password)
  end

  def password=(new_password)
    self.encrypted_password = Password.create(new_password)
  end

  private

  def generate_auth_token
    loop do
      token = SecureRandom.hex
      user = User.find_by(auth_token: token)

      if user.blank?
        self.auth_token = token
        break
      end
    end
  end
end
