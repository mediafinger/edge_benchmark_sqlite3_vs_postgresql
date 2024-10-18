class AddPgIndices < ActiveRecord::Migration[8.0]
  def change
    add_index :pg_comments, :pg_stuff_id
    add_index :pg_reactions, :pg_comment_id
  end
end
