class Message < ActiveRecord::Base

  validates :user_id, presence: true

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

  def chat_show
    {
      body: body,
      username: User.find(user_id).user_name,
      image: User.find(user_id).avatar_url,
      read: read,
      created_at: created_at.strftime("%m/%d/%y at %l:%M %p")
    }.to_json
  end
end
