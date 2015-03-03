require "rails_helper"

RSpec.describe User, :type => :model do
  it "validates that a message belongs to a conversation and a user" do
    lucy = User.create!(first_name: "Lucy",
                              last_name: "van Pelt",
                                  email: "ohbrothercharliebrown@gmail.com",
                                zipcode: "94117",
                               password: "dogs1234",
                               )
     charlie = User.create!(first_name: "Charlie",
                            last_name: "Brown",
                               email: "ilovesnoopy@gmail.com",
                             zipcode: "94117",
                            password: "dogs1234",
                            )
    lucys_conversation = Conversation.create!(user_id: 1,
                                              user_id: 2,
                                              )

    message = Message.create!(conversation_id: 1,
                                      user_id: 1,
                                         body: "Hi Charlie!")

    expect(lucys_conversation.messages.length).to eq(1)
    expect(lucy.conversations.length).to eq(1)
    expect(message.user_id).to eq(1)
  end
end
