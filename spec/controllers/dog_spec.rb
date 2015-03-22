require "rails_helper"

RSpec.describe DogsController do
  xdescribe "POST create" do
    it "assigns @dogs" do
      user = User.create({first_name: "Hilary",
        last_name: "Clinton",
        zipcode: 94118,
        email: "hildog@whitehouse.com",
        password: "1234"})
      dog = user.dogs.create(
        name: "Snoopy",
        breed: "Cartoon",
        gender: "Male",
        age: "2",
        user_id: user.id
      )
      post :create
      expect(dog.zipcode).to eq(94118)
    end
  end
end
