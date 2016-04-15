require 'bcrypt'

class User < ActiveRecord::Base
  # storing encrypted password in self.encrypted_password
  include BCrypt

  before_create :generate_auth_token

  validates :first_name, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }

  def password
    unless encrypted_password.blank?
      Password.new(encrypted_password)
    end
  end

  def password=(new_password)
    self.encrypted_password = Password.create(new_password).to_s
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
