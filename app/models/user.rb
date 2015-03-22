class User < ActiveRecord::Base
  has_secure_password
  has_many :dogs
  has_many :conversations, :foreign_key => :sender_id
  mount_uploader :avatar, AvatarUploader

  validates :email, uniqueness: true
  validates :first_name, :last_name, :email, :password, presence: true
  validates :password, length: {minimum: 4}
  validates :first_name, length: {minimum: 2}

  def full_name
    "#{first_name} #{last_name}"
  end

  def user_name
    "#{first_name} #{last_name[0]}."
  end
end
