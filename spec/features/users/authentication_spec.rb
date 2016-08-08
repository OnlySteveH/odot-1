require 'rails_helper'
require 'rspec/active_model/mocks'

describe "Logging In" do
  it "logs the user and goes to the todo list" do
    User.create(first_name: "Jason", last_name: "Seifer", email: "jason@teamtreehouse.com", password:"password12345", password_confirmation:"password12345")
    visit new_user_session_path
    fill_in "Email Address", with: "jason@teamtreehouse.com"
    fill_in "Password", with: "password12345"
    click_button "Log In"

    expect(page).to have_content("Todo Lists")
    expect(page).to have_content("Thanks for logging in!")
  end

  it "displays the email address in the event of the failed login" do
    visit new_user_session_path
    fill_in "Email Address", with: "jason@teamtreehouse.com"
    fill_in "Password", with: "wrongpassword"
    click_button "Log In"

    expect(page).to have_field("Email Address", with: "jason@teamtreehouse.com")
    expect(page).to have_content("Please check your email and password!")

  end
end