require 'spec_helper'
require 'rspec/active_model/mocks'


describe "Viewing todo items" do

  let!(:todo_list) {TodoList.create(title:"Grocery list", description: "Groceries")}

  it "display no items when todo list is empty" do
    visit"/todo_lists"

  within"#todo_list_#{todo_list.id}" do
    click_link"List Items"
  end
    expect(page).to have_content("TodoItems#index")
  end

end