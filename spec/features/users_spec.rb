require 'rails_helper'

feature "User Profile" do
  scenario "User can edit profile" do
    user = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: 94117,
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )

    visit root_path
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"
    click_on "Barbara Streisand"
    click_on "edit-user-action"
    fill_in "first-name-field", with: "Banana"
    click_on "update-user-action"

    expect(page).to have_content("Banana Streisand")
    expect(page).to have_content("Profile successfully updated")
  end
end
