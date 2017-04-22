class CreateUserSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :user_settings do |t|
      t.references :user, foreign_key: true
      t.boolean :notification_setting, default: true
      t.boolean :email_setting, default: true
      t.string :language

      t.timestamps
    end
  end
end
