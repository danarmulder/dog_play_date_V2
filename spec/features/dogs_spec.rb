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
    click_on "Robert Downey Jr."

    expect(page).to have_content("Iron Dog")
  end

  scenario "User can add dog from their profile page" do
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
    click_on "Barbara Streisand"
    click_on "add-dog-action"

    fill_in "Name", with: "Diva"
    fill_in "Breed", with: "West Highland Terrier"
    fill_in "Age", with: "4"
    fill_in "Size", with: "Large"
    fill_in "Gender", with: "Female"
    click_on "add-dog-action"
    click_on "Barbara Streisand"

    expect(page).to have_content("Diva")
  end

  scenario "User can edit their dog from their profile page" do
    user = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: 94117,
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )
    dog = Dog.create!(
      name: "Snoopy",
      breed: "Cartoon",
      gender: "Male",
      age: "2",
      user_id: user.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"
    click_on "Barbara Streisand"
    click_on "edit-dog-#{dog.id}-action"
    fill_in "Name", with: "Diva"
    click_on "update-dog"

    expect(page).to have_content("Diva")
    expect(page).to have_content("Edit")
  end

  scenario "User can delete a dog from their account" do
    user = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: 94117,
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )
    dog = Dog.create!(
      name: "Snoopy",
      breed: "Cartoon",
      gender: "Male",
      age: "2",
      user_id: user.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"
    click_on "Barbara Streisand"
    click_on "delete-dog-#{dog.id}-action"

    expect(page).to_not have_content("Snoopy")
  end

  scenario "Dog has a default image when no image is added" do
    user = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: 94117,
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )
    dog = Dog.create!(
      name: "Snoopy",
      breed: "Cartoon",
      gender: "Male",
      age: "2",
      user_id: user.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"
    click_on "Barbara Streisand"

    expect(page).to have_css("img#dog_image")
  end

end
