class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.date :due_date
      t.integer :user_id
      t.integer :priority
      t.string :name

      t.timestamps
    end

    add_index :tasks, :user_id
  end
end
