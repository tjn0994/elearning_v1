class CreateTimesheets < ActiveRecord::Migration[5.0]
  def change
    create_table :timesheets do |t|
      t.references :course, foreign_key: true
      t.time :time_from
      t.time :time_to
      t.integer :day_name
      t.timestamps
    end
  end
end
