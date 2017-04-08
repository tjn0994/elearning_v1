class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.references :course, foreign_key: true
      t.string :name
      t.string :description
      t.text :content
      t.timestamps
    end
  end
end
