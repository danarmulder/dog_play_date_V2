require "rails_helper"

RSpec.describe Dog, :type => :model do

  it "validates that a dog belongs to a user" do
    dog_lover = User.create(first_name: "Lucy",
    last_name: "van Pelt",
    email: "ohbrothercharliebrown@gmail.com",
    zipcode: "94117",
    password: "dogs1234",
    )
    lucys_dog = Dog.create(name: "Snoopy",
    breed: "Cartoon",
    gender: "Male",
    user_id: dog_lover.id
    )

    expect(lucys_dog.user.first_name).to eq("Lucy")
  end

  it "validates that a dog has a name" do
    dog_lover = User.create(first_name: "Lucy",
    last_name: "van Pelt",
    email: "ohbrothercharliebrown@gmail.com",
    zipcode: "94117",
    password: "dogs1234",
    )
    lucys_dog = Dog.create(
    breed: "Cartoon",
    gender: "Male",
    user_id: dog_lover.id
    )

    expect(dog_lover.dogs.length).to eq(0)
  end

  it "validates that a dog has a gender" do
    dog_lover = User.create(first_name: "Lucy",
    last_name: "van Pelt",
    email: "ohbrothercharliebrown@gmail.com",
    zipcode: 94117,
    password: "dogs1234",
    )
    lucys_dog = Dog.create(name: "Snoopy",
    breed: "Cartoon",
    user_id: dog_lover.id
    )

    expect(dog_lover.dogs.length).to eq(0)
  end

  it "validates that a dog has a breed" do
    dog_lover = User.create(first_name: "Lucy",
    last_name: "van Pelt",
    email: "ohbrothercharliebrown@gmail.com",
    zipcode: 94117,
    password: "dogs1234",
    )
    lucys_dog = Dog.create(name: "Snoopy",
    gender: "Male",
    user_id: dog_lover.id
    )

    expect(dog_lover.dogs.length).to eq(0)
  end

end
