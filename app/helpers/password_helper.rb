module PasswordHelper
  require 'securerandom'

  def secure_password
    SecureRandom.hex
  end
end
