require 'rails_helper'

feature "filtering dog friend suggestions" do
  it "when user creates a dog, a location filter is automatically created" do
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
    click_on "top-signup-button"
    fill_in "First name", with: "Robert"
    fill_in "Last name", with: "Downey Jr."
    fill_in "Email", with: "sherlockholmes@yahoo.com"
    fill_in "Zipcode", with: 94117
    fill_in "Password", with: "1234"
    fill_in "Password confirmation", with: "1234"
    click_on "sign-up"
    click_on "Robert-profile-path"
    click_on "Add Dog"

    fill_in "Name", with: "Diva"
    fill_in "Breed", with: "West Highland Terrier"
    fill_in "Age", with: "4"
    click_on "add-dog-action"


    expect(page).to have_content("Fido")
    expect(page).to have_content("94117")
    expect(page).not_to have_content("Lucky")
  end

  it "user can create filters" do
    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Garfield",
      email: "Andrew@Garfield.com",
      zipcode: 94118,
      password: "12345678"
    )

    lola = Dog.create!(
      name: "Lola",
      breed: "West Highland Terrier",
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
    click_on "top-signup-button"
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
    click_on "add-dog-action"

    fill_in "breed-field", with: "West Highland Terrier"
    click_on "breed-submit-filters"

    expect(page).to have_content("Lola")
    expect(page).not_to have_content("Lucky")
  end
  it "user can edit preferences" do
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
      zipcode: 94103,
      password: "12345678"
    )

    lola = Dog.create!(
      name: "Lola",
      breed: "Lab",
      age: "5",
      size: "Large",
      play: "Toy-Motivated",
      gender: "Female",
      personality: "Dominant",
      zipcode: 94110,
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
      zipcode: 94103,
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
  it "user can delete filters" do
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

    lola = Dog.create!(
      name: "Lola",
      breed: "Lab",
      age: "5",
      size: "Large",
      play: "Toy-Motivated",
      gender: "Female",
      personality: "Laid-Back",
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
      personality: "Confident",
      zipcode: 94117,
      user_id: andrew.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"
    click_on "#{user.first_name}-profile-path"
    click_on "preferences-link"
    click_on "delete-filter-#{filter.id}-action"

    expect(page).not_to have_content("Preferences Breed: Lab")
  end
  it "A user can filter dogs based on Personality" do
    user = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: 94117,
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )

    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Garfield",
      email: "Andrew@Garfield.com",
      zipcode: 94114,
      password: "12345678"
    )

    lola = Dog.create!(
      name: "Lola",
      breed: "Lab",
      age: "5",
      size: "Large",
      play: "Toy-Motivated",
      gender: "Female",
      personality: "Confident",
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
      personality: "Laidback",
      zipcode: 94117,
      user_id: andrew.id
    )

    puddle = Dog.create!(
      name: "Puddle",
      breed: "shar pei",
      age: "2",
      size: "Medium",
      play: "Food-Motivated",
      gender: "Female",
      personality: "Laid-Back",
      zipcode: 94117,
      user_id: user.id
    )

    filter = Filter.create!(
      type: "Personality",
      content: "Laidback",
      user_id: user.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"
    click_on "#{user.first_name}-profile-path"
    click_on "preferences-link"

    expect(page).to have_content("Lucky")
    expect(page).not_to have_content("Lola")
    expect(page).to have_content("Personality Preference: Laidback")
  end
  it "filters do not include a user's dog" do
    user = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: 94117,
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )

    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Garfield",
      email: "Andrew@Garfield.com",
      zipcode: 94114,
      password: "12345678"
    )

    lola = Dog.create!(
      name: "Lola",
      breed: "Lab",
      age: "5",
      size: "Large",
      play: "Toy-Motivated",
      gender: "Female",
      personality: "Confident",
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
      personality: "Laid-Back",
      zipcode: 94117,
      user_id: andrew.id
    )

    puddle = Dog.create!(
      name: "Puddle",
      breed: "shar pei",
      age: "2",
      size: "Medium",
      play: "Food-Motivated",
      gender: "Female",
      personality: "Laid-Back",
      zipcode: 94117,
      user_id: user.id
    )

    filter = Filter.create!(
      type: "Personality",
      content: "Laid-Back",
      user_id: user.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"
    click_on "#{user.first_name}-profile-path"
    click_on "preferences-link"

    expect(page).to have_content("Lucky")
    expect(page).not_to have_content("Lola")
    expect(page).not_to have_content("Puddle")
    expect(page).to have_content("Personality Preference: Laid-Back")
  end
  scenario "a user can block another user from their profile page" do
    user = User.create!(
      first_name: "Barbara",
      last_name: "Streisand",
      zipcode: 94117,
      email: "barbarastreisand@aol.com",
      password: "1234",
      password_confirmation: "1234"
    )

    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Garfield",
      email: "Andrew@Garfield.com",
      zipcode: 94114,
      password: "12345678"
    )

    lucky = Dog.create!(
      name: "Lucky",
      breed: "shar pei",
      age: "2",
      size: "Medium",
      play: "Food-Motivated",
      gender: "Female",
      personality: "Laid-Back",
      zipcode: 94117,
      user_id: andrew.id
    )

    puddle = Dog.create!(
      name: "Puddle",
      breed: "shar pei",
      age: "2",
      size: "Medium",
      play: "Food-Motivated",
      gender: "Female",
      personality: "Laid-Back",
      zipcode: 94117,
      user_id: user.id
    )

    convo = Conversation.create!(
      sender_id: user.id,
      recipient_id: andrew.id,
    )

    andrews_message = convo.messages.create!(
      body: "Hey there! Cute dog",
      user_id: andrew.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "barbarastreisand@aol.com"
    fill_in "Password", with: "1234"
    click_on "signing-user-in-action"
    click_on "#{user.first_name}-profile-path"
    expect(page).to have_content("Block User")
    click_on "block-user-#{andrew.id}-action"
    click_on "Barbara Streisand"

    expect(page).not_to have_content("Hey there! Cute dog")
    expect(page).not_to have_content("Lucky")
    expect(page).to have_content("Preference Blocked User: Andrew G.")
  end
end
