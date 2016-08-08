require 'rspec/active_model/mocks'

describe "Listing todo list" do
  it "required login" do
    visit "/todo_lists"
    expect(page).to have_content("You must be logged in")

  end
end
