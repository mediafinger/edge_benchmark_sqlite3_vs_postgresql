class CreateLiteStuffs < ActiveRecord::Migration[8.0]
  def change
    create_table :lite_stuffs do |t|
      t.string :name
      t.text :body
      t.boolean :active

      t.timestamps
    end
  end
end
