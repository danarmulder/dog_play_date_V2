require "rails_helper"

RSpec.describe User, :type => :model do

  it "validates that a dog belongs to a user" do
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

    expect(dogs.user.first_name).to eq("Lucy")
  end

  it "validates that a dog has a name" do
    dog_lover = User.create!(first_name: "Lucy",
    last_name: "van Pelt",
    email: "ohbrothercharliebrown@gmail.com",
    zipcode: "94117",
    password: "dogs1234",
    )
    lucys_dog = Dog.create!(
    breed: "Cartoon",
    gender: "Male",
    user: "1"
    )

    expect(dog_lover.dogs.length).to eq(0)
  end

  it "validates that a dog has a gender" do
    dog_lover = User.create!(first_name: "Lucy",
    last_name: "van Pelt",
    email: "ohbrothercharliebrown@gmail.com",
    zipcode: "94117",
    password: "dogs1234",
    )
    lucys_dog = Dog.create!(name: "Snoopy",
    breed: "Cartoon",
    gender:,
    user: "1"
    )

    expect(dog_lover.dogs.length).to eq(0)
  end

  it "validates that a dog has a breed" do
    dog_lover = User.create!(first_name: "Lucy",
    last_name: "van Pelt",
    email: "ohbrothercharliebrown@gmail.com",
    zipcode: "94117",
    password: "dogs1234",
    )
    lucys_dog = Dog.create!(name: "Snoopy",
    breed:,
    gender: "Male",
    user: "1"
    )

    expect(dog_lover.dogs.length).to eq(0)
  end

  it "validates that a dog without an image has the default image" do
    lucys_dog = Dog.create!(name: "Snoopy",
    breed:"Cartoon",
    gender: "Male",
    user: "1"
    )
    expect(lucys_dog.image).to eq("/images/normal/missingdog.jpg")
  end

end
