class CreateExams < ActiveRecord::Migration[5.0]
  def change
    create_table :exams do |t|
      t.references :user, foreign_key: true
      t.references :lesson, foreign_key: true
      t.string :name
      t.time :time
      t.integer :score
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
