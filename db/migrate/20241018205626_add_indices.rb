class AddIndices < ActiveRecord::Migration[8.0]
  def change
    add_index :comments, :lite_stuff_id
    add_index :reactions, :comment_id
  end
end
