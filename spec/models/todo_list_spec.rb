require 'rails_helper'

describe TodoList do
  
  context "relationships" do
    it { should have_many(:todo_items) }
    it { should belong_to(:user)}
  end

  describe "#has_completed_items?" do

    let(:todo_list) { TodoList.create(title: "Groceries", description:"Grocery list")}

    it "returns true with completed todo list items" do
      todo_list.todo_items.create(content:"Eggs", completed_at: 1.minute.ago)
      expect(todo_list.has_completed_items?).to be true
    end

    it "returns false with completed todo list items" do
      todo_list.todo_items.create(content:"Eggs")
      expect(todo_list.has_completed_items?).to be_falsey
    end
  end

  describe "#has_incomplte_items?" do

    let(:todo_list) { TodoList.create(title: "Groceries", description:"Grocery list")}

    it "returns true with incompleted todo list items" do
      todo_list.todo_items.create(content:"Eggs")
      expect(todo_list.has_incompleted_items?).to be true
    end

    it "returns false with incompleted todo list items" do
      todo_list.todo_items.create(content:"Eggs", completed_at: 1.minutes.ago)
      expect(todo_list.has_incompleted_items?).to be_falsey
    end
  end
end
