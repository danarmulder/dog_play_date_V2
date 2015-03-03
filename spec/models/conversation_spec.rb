equire "rails_helper"

RSpec.describe User, :type => :model do
  it "validates that a conversation belongs to two users" do
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

    expect(lucy.conversations.length).to eq(1)
    expect(charlie.conversations.length).to eq(1)
  end

  it "validates that a conversation has messages" do
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

    message = Message.create!(conversation_id: 1, user_id: 1, body: "Hi Charlie!")
    expect(charlie.conversations.messages.length).to eq(1)
  end

  it "validates the uniqueness of the conversation" do
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
    l_and_c_conversation = Conversation.create!(user_id: 1,
                                              user_id: 2,
                                              )
    l_and_c_conversation2 = Conversation.create!(user_id: 1,
                                                user_id: 2,
                                                )
    expect(lucy.conversations.length).to eq(1)                                                                                      
  end
end
