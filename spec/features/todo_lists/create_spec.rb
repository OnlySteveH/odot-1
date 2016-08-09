require 'rails_helper'
require 'rspec/active_model/mocks'

describe "Creating todo list" do
  let(:user){ create(:user) }



  def create_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "This is what I have to do today."

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in  "Title", with: options[:title]
    fill_in  "Description", with: options[:description]
    click_button "Create Todo list"
  end

  before do
    sign_in user, password: "treehouse1"
  end

  it "redirects to the todo list index page on success" do
    create_todo_list
    expect(page).to have_content("My todo list")
  end

  it "display an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is what I have to do today.")
  end

  it "display an error when the todo list has a title less than 3 characters" do
    expect(TodoList.count).to eq(0)

    create_todo_list title:"Hi"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is what I have to do today.")
  end

  it "display an error when the todo list has no description" do
    expect(TodoList.count).to eq(0)

    create_todo_list description: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Grocery list")
  end

  it "display an error when the todo list has a description less than 5 characters" do
    expect(TodoList.count).to eq(0)

    create_todo_list description: "food"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Grocery list")
  end
end