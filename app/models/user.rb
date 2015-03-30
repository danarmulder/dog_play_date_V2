class User < ActiveRecord::Base
  has_secure_password
  has_many :dogs
  has_many :conversations, :foreign_key => :sender_id
  has_many :conversations, :foreign_key => :recipient_id
  has_many :filters

  delegate :breeds, :sizes, :ages, :personalities, :plays, :blocked_users, :genders, :zipcodes, to: :filters
  mount_uploader :avatar, AvatarUploader, :default_user_url => "/images/fallback/missinguser.jpg"

  validates :email, uniqueness: true
  validates :first_name, :last_name, :email, presence: true
  validates :password, presence: true, :if => :password
  validates :password, length: {minimum: 4}, :if => :password
  validates :first_name, length: {minimum: 2}

  def full_name
    "#{first_name} #{last_name}"
  end

  def user_name
    "#{first_name} #{last_name[0]}."
  end


  def unread_messages_count(user_id)
    count = 0
    conversations.each do |conversation|
      conversation.messages.each do |message|

        if user_id != message.user_id
          if message.read == false
            count += 1
          end
        end
      end
    end
    count
  end

  def blocked_users_info
    blocked_user_info = []
    blocked_users.each do |blocked_id|
      blocked = {}
      blocked[:user] = User.find(blocked_id.content.to_i)
      blocked[:filter_id] = blocked_id.id
      blocked_user_info.push(blocked)
    end
    blocked_user_info
  end
end
