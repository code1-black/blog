class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :user, null: true, foreign_key: true
      t.references :post, null: true, foreign_key: true

      t.timestamps
    end
  end
end
