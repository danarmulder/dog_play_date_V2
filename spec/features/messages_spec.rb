require 'rails_helper'

feature "User can send and recieve messages with other users" do
  scenario "User can send a message to another user and see it on their profile page" do
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

    click_on "Barbara Streisand"

    expect(page).to have_content("Hello Robert")
  end

  scenario "Users can receive a message from another user" do
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

    convo = Conversation.create!(
      sender_id: barbara.id,
      recipient_id: robert.id,
    )

    robs_message = convo.messages.create!(
      body: "Hey there! Cute dog",
      user_id: robert.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"
    click_on "Barbara Streisand"

    expect(page).to have_content("Hey there! Cute dog")
  end

  scenario "user can reply to a message from another user" do
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

    convo = Conversation.create!(
      sender_id: barbara.id,
      recipient_id: robert.id,
    )

    robs_message = convo.messages.create!(
      body: "Hey there! Cute dog",
      user_id: robert.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"
    click_on "Barbara Streisand"
    click_on "see-message-from-#{robert.id}-action"
    fill_in "Body", with: "thanks! our dogs should hang out"
    click_on "send"

    expect(page).to have_content("thanks! our dogs should hang out")
  end

  scenario "if a user clicks to message it will go to previously existing conversation" do
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

    convo = Conversation.create!(
      sender_id: barbara.id,
      recipient_id: robert.id,
    )

    robs_message = convo.messages.create!(
      body: "Hey there! Cute dog",
      user_id: robert.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"
    click_on "message-user-#{robert.id}"

    expect(page).to have_content("Hey there! Cute dog")
  end

  scenario "User can see that he/she has an unread message" do
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
    convo = Conversation.create!(
      sender_id: barbara.id,
      recipient_id: robert.id,
    )

    robs_message = convo.messages.create!(
      body: "Hey there! Cute dog",
      user_id: robert.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"

    expect(page).to have_content("1")
  end
end
