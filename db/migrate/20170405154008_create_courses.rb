class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.references :category, foreign_key: true
      t.string :name
      t.string :description
      t.string :image
      t.integer :owner_id
      t.integer :approver_id
      t.timestamps
    end
  end
end