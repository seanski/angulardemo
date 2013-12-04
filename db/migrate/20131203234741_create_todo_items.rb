class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.string :description
      t.date :due_date
      t.boolean :completed

      t.timestamps
    end
  end
end
