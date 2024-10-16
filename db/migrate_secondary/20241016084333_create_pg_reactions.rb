class CreatePgReactions < ActiveRecord::Migration[8.0]
  def change
    create_table :pg_reactions do |t|
      t.string :body
      t.integer :pg_comment_id

      t.timestamps
    end
  end
end
