require 'rails_helper'
require 'rspec/active_model/mocks'


describe "Adding todo items" do

  let(:user){ todo_list.user }
  let!(:todo_list) {create(:todo_list)}
  let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }
  before { sign_in user, password: 'treehouse1' }

  it "is successful with valid content" do
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: "Milk"
    click_button "Save"

    expect(page).to have_content("Added todo list item")

    within("table.todo_items") do
      expect(page).to have_content("Milk")
    end
  end

  it "display an error with no content" do
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: ""
    click_button "Save"

    within("div.flash") do
      expect(page).to have_content("There was an error")
    end

    expect(page).to have_content("Content can't be blank")
  end

  it "display an error with content less than 2 charaters long" do
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: "1"
    click_button "Save"

    within("div.flash") do
      expect(page).to have_content("There was an error")
    end

    expect(page).to have_content("Content is too short")
  end
end
