require 'rails_helper'

feature "Sign In" do
  scenario "User signs in" do
    user = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: 94117,
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"


    expect(page).to have_content("Barbara Streisand")
    expect(page).to have_content("Sign Out")
  end

  scenario "User signs in with wrong password and is not permitted" do
    user = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: 94117,
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "123"
    click_on "signing-user-in-action"

    expect(page).to have_no_content("Sign Out")
    expect(page).to have_content("Email/password combination is invalid")
  end

  scenario "User signs in with wrong email and is not permitted" do
    user = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: "94117",
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "b-barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"


    expect(page).to have_no_content("Sign Out")
    expect(page).to have_content("Email/password combination is invalid")
  end

  scenario "User tries to sign in with blank fields and is not permitted" do
    user = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: "94117",
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: " "
    fill_in "Password", with: " "
    click_on "signing-user-in-action"


    expect(page).to have_no_content("Sign Out")
    expect(page).to have_content("Email/password combination is invalid")
  end
end

feature "Sign Out" do
  scenario "A user can sign out" do
    user = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: "94117",
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"

    expect(page).to have_content("Sign Out")
    click_on "Sign Out"

    expect(page).to have_no_content("Sign Out")
    expect(page).to have_content("Sign In")
  end
end
