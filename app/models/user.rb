class User < ApplicationRecord
  has_secure_password

  # Adding validation for attributes
  validates :user_name, presence: true, uniqueness: true
  validates :email, presence: true
  # validates :password, presence: true, length: { minimum: 6 }

  # # Adding validation for password
  # validate :password_complexity

  # private

  # def password_complexity
  #   return if password.blank? || password =~ /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)./

  #   errors.add :password, 'Complexity requirement not met. Length should be 6 characters and include: 1 uppercase, 1 lowercase and 1 digit'
  # end
end
