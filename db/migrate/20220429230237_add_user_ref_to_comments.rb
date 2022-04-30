class AddUserRefToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :author_id, :bigint, null: false
    add_index :comments, :author_id
    add_foreign_key :comments, :users, column: :author_id
  end
end