class AddUserIdToTodoItems < ActiveRecord::Migration
  def change
    add_reference :todo_items, :user, index: true
  end
end
