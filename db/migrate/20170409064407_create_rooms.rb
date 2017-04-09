class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.references :course, foreign_key: true
      t.string :name
      t.string :session_id
      t.integer :owner_id
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
