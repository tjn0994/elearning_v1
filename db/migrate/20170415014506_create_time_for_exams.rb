class CreateTimeForExams < ActiveRecord::Migration[5.0]
  def change
    create_table :time_for_exams do |t|
      t.references :lesson, foreign_key: true
      t.time :time
      t.integer :number_question

      t.timestamps
    end
  end
end
