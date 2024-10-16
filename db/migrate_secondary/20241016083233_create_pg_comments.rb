class CreatePgComments < ActiveRecord::Migration[8.0]
  def change
    create_table :pg_comments do |t|
      t.string :name
      t.text :body
      t.boolean :active
      t.integer :pg_stuff_id

      t.timestamps
    end
  end
end
