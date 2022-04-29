class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.integer :comments_counter
      t.integer :likes_counter
      t.bigint :author_id

      t.timestamps
    end
    add_index :posts, :author_id
    add_foreign_key :posts, :users, column: :author_id
  end
end
