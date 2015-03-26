class Message < ActiveRecord::Base

  validates :user_id, presence: true

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
