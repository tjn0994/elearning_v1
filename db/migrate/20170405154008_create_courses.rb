class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.references :type, foreign_key: true
      t.string :name
      t.string :description
      t.string :image
      t.integer :owner_id
      t.integer :approver_id
      t.integer :status, default: 0
      t.datetime :date_open
      t.datetime :date_close
      t.date :date_from
      t.date :date_to
      t.timestamps
    end
  end
end
