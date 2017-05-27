class CreateRegisterCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :register_courses do |t|
      t.references :course, foreign_key: true
      t.date :date_open
      t.date :date_close
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
