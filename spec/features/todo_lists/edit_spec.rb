require 'rails_helper'
require 'rspec/active_model/mocks'


describe "Editing todo list" do
  let(:user){ todo_list.user }
  let!(:todo_list) {create(:todo_list)}

  def update_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "This is what I have to do today."

    todo_list = options[:todo_list]

    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"
  end

  before do
    sign_in todo_list.user, password: "treehouse1"
  end


  it "updates a todo list successfully with correct information " do

    update_todo_list  todo_list: todo_list,
                      title: "New title",
                      description: "New description"
    todo_list.reload

    expect(page).to have_content("Todo list was successfully updated")
    expect(todo_list.title).to eq("New title")
    expect(todo_list.description).to eq("New description")
  end

  it "display an error with no title" do
    update_todo_list todo_list: todo_list, title:""
    title = todo_list.title
    todo_list.reload
    expect(todo_list.title).to eq(title)
    expect(page).to have_content("error")
  end

  it "display an error with no description" do
    update_todo_list todo_list: todo_list, description:""
    expect(page).to have_content("error")
  end

  it "display an error with too short title" do
    update_todo_list todo_list: todo_list, title:"Hi"
    expect(page).to have_content("error")
  end

  it "display an error with too short description" do
    update_todo_list todo_list: todo_list, description:"Food"
    expect(page).to have_content("error")
  end
end