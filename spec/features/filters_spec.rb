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
    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Garfield",
      email: "Andrew@Garfield.com",
      zipcode: 94118,
      password: "12345678"
    )

    fido = Dog.create!(
      name: "Lola",
      breed: "Lab",
      age: "5",
      size: "Large",
      play: "Toy-Motivated",
      gender: "Female",
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

    fill_in "size-field", with: "Large"
    click_on "size-submit-filters"

    fill_in "gender-field", with: "Female"
    click_on "gender-submit-filters"

    expect(page).to have_content("Lola")
    expect(page).not_to have_content("Lucky")
  end
  scenario "user can edit preferences" do
    user = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: 94117,
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )

    filter = user.filters.create!(
      type: "Zipcode",
      content: "94117"
    )

    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Garfield",
      email: "Andrew@Garfield.com",
      zipcode: 94114,
      password: "12345678"
    )

    fido = Dog.create!(
      name: "Lola",
      breed: "Lab",
      age: "5",
      size: "Large",
      play: "Toy-Motivated",
      gender: "Female",
      personality: "Dominant",
      zipcode: 94114,
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
      zipcode: 94117,
      user_id: andrew.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"
    click_on "Barbara Streisand"
    click_on "preferences-link"
    click_on "edit-filter-#{filter.id}"

    fill_in "content-field", with: "94114"
    click_on "update-action"

    expect(page).to have_content("94114")
    expect(page).to have_content("Lola")
    expect(page).not_to have_content("Lucky")
  end
  xscenario "user can delete filters" do
    user = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: 94117,
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )

    filter = user.filters.create!(
      type: "Breed",
      content: "Lab"
    )

    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Garfield",
      email: "Andrew@Garfield.com",
      zipcode: 94114,
      password: "12345678"
    )

    fido = Dog.create!(
      name: "Lola",
      breed: "Lab",
      age: "5",
      size: "Large",
      play: "Toy-Motivated",
      gender: "Female",
      personality: "Dominant",
      zipcode: 94114,
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
      zipcode: 94117,
      user_id: andrew.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"
    click_on "Barbara Streisand"
    click_on "preferences-link"
    click_on "delete-filter-#{filter.id}-action"

    expect(page).not_to have_content("Breed: Lab")
  end
end
