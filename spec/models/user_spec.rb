require "rails_helper"

RSpec.describe User, :type => :model do
  it "validates the user is not created without an email" do
    lindeman = User.create!(first_name: "Andy", last_name: "Lindeman")

    expect(User.all.length).to eq(0)
  end

  it "validates the password is longer than 3 characters" do
    dog_lover = User.create!(first_name: "Lucy",
                              last_name: "van Pelt",
                                  email: "ohbrothercharliebrown@gmail.com",
                                zipcode: "94117",
                               password: "dog",
                               )

    expect(User.all.length).to eq(0)
  end

  it "validates the first name is longer than 1 character" do
    dog_lover = User.create!(first_name: "L",
                              last_name: "van Pelt",
                                  email: "ohbrothercharliebrown@gmail.com",
                                zipcode: "94117",
                               password: "dogs",
                               )

    expect(User.all.length).to eq(0)
  end

  it "validates that a user can own a dog" do
    dog_lover = User.create!(first_name: "Lucy",
                              last_name: "van Pelt",
                                  email: "ohbrothercharliebrown@gmail.com",
                                zipcode: "94117",
                               password: "dogs1234",
                               )
    lucys_dog = Dog.create!(name: "Snoopy",
                            breed: "Cartoon",
                            gender: "Male",
                            user: "1"
                            )

    expect(dog_lover.dogs.length).to eq(1)
  end

  it "validates that a user who signs up without an image has the default image" do
    dog_lover = User.create!(first_name: "Lucy",
                              last_name: "van Pelt",
                                  email: "ohbrothercharliebrown@gmail.com",
                                zipcode: "94117",
                               password: "dogs1234",
                               )
    dog_lover.avatar = "/images/normal/missinguser.jpg"
  end

  it "validates that a user can have a conversation" do
    dog_lover = User.create!(first_name: "Lucy",
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
    lucys_dog = Conversation.create!(user_id: 1,
                                    user_id: 2,
                                    )

    expect(dog_lover.conversations.length).to eq(1)
  end
end
