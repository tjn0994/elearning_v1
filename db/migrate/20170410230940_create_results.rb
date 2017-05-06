class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.references :exam, foreign_key: true
      t.references :question, foreign_key: true
      t.string :answer_ids
      t.boolean :is_correct, default: false
      t.timestamps
    end
  end
end
