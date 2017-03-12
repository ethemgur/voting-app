class CreateElements < ActiveRecord::Migration[5.0]
  def change
    create_table :elements do |t|
      t.text :name
      t.string :belong

      t.timestamps
    end
  end
end
