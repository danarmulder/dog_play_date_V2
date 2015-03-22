require 'rails_helper'

feature "User can send and recieve messages with other users" do
  scenario "User can send a message to a person" do
    barbara = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: 94117,
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )

    robert = User.create!(
      first_name: "Robert",
      last_name: "Downey Jr.",
      zipcode: 94117,
      email: "robertdowney@gmail.com",
      password: "1234",
      password_confirmation: "1234"
    )

    roberts_dog = Dog.create!(
      name: "Iron Dog",
      breed: "Doberman",
      gender: "Male",
      age: "2",
      user_id: robert.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"
    click_on "message-user-#{robert.id}"
    fill_in "Body", with: "Hello Robert"
    click_on "send"

    expect(page).to have_content("Hello Robert")
  end
  
end
