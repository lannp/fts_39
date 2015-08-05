class CreateAnswerSheets < ActiveRecord::Migration
  def change
    create_table :answer_sheets do |t|
      t.references :user, index: true, foreign_key: true
      t.references :exam, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
