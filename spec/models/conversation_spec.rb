require "rails_helper"

RSpec.describe Conversation, :type => :model do
  it "validates that a conversation belongs to two users" do
    lucy = User.create!(
      first_name: "Lucy",
      last_name: "van Pelt",
      email: "ohbrothercharliebrown@gmail.com",
      zipcode: 94117,
      password: "dogs1234",
      )

     charlie = User.create!(
      first_name: "Charlie",
      last_name: "Brown",
      email: "ilovesnoopy@gmail.com",
      zipcode: 94117,
      password: "dogs1234",
      )
    lucys_conversation = Conversation.create!(
      sender_id: lucy.id,
      recipient_id: charlie.id,
    )

    expect(charlie.conversations.length).to eq(1)
  end

  it "validates that a conversation has messages" do
    lucy = User.create!(
      first_name: "Lucy",
      last_name: "van Pelt",
      email: "ohbrothercharliebrown@gmail.com",
      zipcode: "94117",
      password: "dogs1234",
    )
     charlie = User.create!(
      first_name: "Charlie",
      last_name: "Brown",
      email: "ilovesnoopy@gmail.com",
      zipcode: "94117",
      password: "dogs1234",
      )
    lucys_conversation = Conversation.create!(
      sender_id: lucy.id,
      recipient_id: charlie.id,
      )

    message = Message.create!(
      conversation_id: lucys_conversation.id,
      user_id: lucy.id,
      body: "Hi Charlie!"
    )

    expect(lucys_conversation.messages.length).to eq(1)
    expect(charlie.conversations.length).to eq(1)
  end

  xit "validates the uniqueness of the conversation" do
    lucy = User.create!(
      first_name: "Lucy",
      last_name: "van Pelt",
      email: "ohbrothercharliebrown@gmail.com",
      zipcode: "94117",
      password: "dogs1234",
    )
   charlie = User.create!(
    first_name: "Charlie",
    last_name: "Brown",
    email: "ilovesnoopy@gmail.com",
    zipcode: "94117",
    password: "dogs1234",
    )

    l_and_c_conversation = Conversation.create!(
      sender_id: lucy.id,
      recipient_id: charlie.id,
    )

    l_and_c_conversation2 = Conversation.create!(
      sender_id: charlie.id,
      recipient_id: lucy.id,
    )

    expect(lucy.conversations.length).to eq(0)
  end
end
