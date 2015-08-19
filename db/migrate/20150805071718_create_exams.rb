class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :status
      t.boolean :checked

      t.timestamps null: false
    end
  end
end
