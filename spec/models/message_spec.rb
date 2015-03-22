require "rails_helper"

RSpec.describe Message, :type => :model do
  it "validates that a message belongs to a conversation and a user" do
    lucy = User.create!(first_name: "Lucy",
                              last_name: "van Pelt",
                                  email: "ohbrothercharliebrown@gmail.com",
                                zipcode: 94117,
                               password: "dogs1234",
                               )
     charlie = User.create!(first_name: "Charlie",
                            last_name: "Brown",
                               email: "ilovesnoopy@gmail.com",
                             zipcode: 94117,
                            password: "dogs1234",
                            )
    lucys_conversation = Conversation.create!(sender_id: lucy.id,
                                              recipient_id: charlie.id,
                                              )

    message = Message.create!(conversation_id: lucys_conversation.id,
                                      user_id: lucy.id,
                                         body: "Hi Charlie!")

    expect(lucys_conversation.messages.length).to eq(1)
    expect(lucy.conversations.length).to eq(1)
    expect(message.user_id).to eq(lucy.id)
  end
end
