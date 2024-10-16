class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.string :name
      t.text :body
      t.boolean :active
      t.integer :lite_stuff_id

      t.timestamps
    end
  end
end
