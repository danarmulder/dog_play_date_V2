require 'rails_helper'

feature "filtering dog friend suggestions" do
  scenario "when user creates a dog location filter is automatically created" do
    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Garfield",
      email: "Andrew@Garfield.com",
      zipcode: 94118,
      password: "12345678"
    )


    fido = Dog.create!(
      name: "Fido",
      breed: "Lab",
      age: "5",
      size: "Small",
      play: "Toy-Motivated",
      gender: "Male",
      personality: "Dominant",
      zipcode: 94117,
      user_id: andrew.id
    )

    lucky = Dog.create!(
      name: "Lucky",
      breed: "shar pei",
      age: "2",
      size: "Medium",
      play: "Food-Motivated",
      gender: "Female",
      personality: "Submissive",
      zipcode: 80128,
      user_id: andrew.id
    )

    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Robert"
    fill_in "Last name", with: "Downey Jr."
    fill_in "Email", with: "sherlockholmes@yahoo.com"
    fill_in "Zipcode", with: 94117
    fill_in "Password", with: "1234"
    fill_in "Password confirmation", with: "1234"
    click_on "sign-up"
    click_on "Robert Downey Jr."
    click_on "Add Dog"

    fill_in "Name", with: "Diva"
    fill_in "Breed", with: "West Highland Terrier"
    fill_in "Age", with: "4"
    fill_in "Size", with: "Small"
    fill_in "Gender", with: "Female"
    click_on "add-dog-action"


    expect(page).to have_content("Fido")
    expect(page).not_to have_content("Lucky")
  end

  scenario "user can create filters" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Robert"
    fill_in "Last name", with: "Downey Jr."
    fill_in "Email", with: "sherlockholmes@yahoo.com"
    fill_in "Zipcode", with: 94117
    fill_in "Password", with: "1234"
    fill_in "Password confirmation", with: "1234"
    click_on "sign-up"
    click_on "Robert Downey Jr."
    click_on "Add Dog"

    fill_in "Name", with: "Diva"
    fill_in "Breed", with: "West Highland Terrier"
    fill_in "Age", with: "4"
    fill_in "Size", with: "Small"
    fill_in "Gender", with: "Female"
    click_on "add-dog-action"

    fill_in "Size", with: "Large"
    fill_in "Gender", with: "Female"
    click_on "submit-filters"
  end
  scenario "user can delete filters" do

  end
end
