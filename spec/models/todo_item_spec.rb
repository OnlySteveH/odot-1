require 'rails_helper'

describe TodoItem do
  #it { should belong_to(:todo_list) }

  describe "#completed?" do
    let(:todo_item) {TodoItem.create(content: "Hello")}

    it "is false when complted_at is blank" do
      todo_item.completed_at = nil
      expect(todo_item.completed?).to be_falsey
    end

    it "is true when complted_at is not empty" do
      todo_item.completed_at = Time.now
      expect(todo_item.completed?).to be_truthy
    end
  end
end
