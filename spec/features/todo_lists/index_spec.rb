require 'rails_helper'
require 'rspec/active_model/mocks'
require 'database_cleaner'

describe "Listing todo list" do
  it "requires login" do
    visit "/todo_lists"
    expect(page).to have_content("You must be logged in")

  end
end
