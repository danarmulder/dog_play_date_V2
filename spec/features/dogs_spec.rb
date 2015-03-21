require 'rails_helper'

feature "CRUD dogs" do
  scenario "After sign-up a user creates a dog" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Robert"
    fill_in "Last name", with: "Downey Jr."
    fill_in "Email", with: "sherlockholmes@yahoo.com"
    fill_in "Zipcode", with: 94117
    fill_in "Password", with: "1234"
    fill_in "Password confirmation", with: "1234"
    click_on "sign-up"
    fill_in "Name", with: "Iron Dog"
    fill_in "Breed", with: "Doberman"
    fill_in "Age", with: "2"
    fill_in "Size", with: "Large"
    fill_in "Gender", with: "Male"
    click_on "add-dog-action"

    expect(page).to have_content("Iron Dog")
    expect(page).to have_content("Edit Dog")
  end
end
