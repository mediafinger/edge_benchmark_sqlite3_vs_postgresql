class CreateReactions < ActiveRecord::Migration[8.0]
  def change
    create_table :reactions do |t|
      t.string :body
      t.integer :comment_id

      t.timestamps
    end
  end
end
