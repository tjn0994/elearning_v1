class CreatePostTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :post_types do |t|
      t.references :post, foreign_key: true
      t.references :type, foreign_key: true

      t.timestamps
    end
  end
end
