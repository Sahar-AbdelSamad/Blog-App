class AddAuthorIdToLikes < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :author_id, :bigint, null: false
    add_index :likes, :author_id
  end
end
