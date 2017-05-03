class CreateRegisterCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :register_courses do |t|
      t.references :course, foreign_key: true
      t.datetime :date_open
      t.datetime :date_close
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
