class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def user_name
    "#{first_name} #{last_name[0]}."
  end
end