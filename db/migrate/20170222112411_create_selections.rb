class CreateSelections < ActiveRecord::Migration[5.0]
  def change
    create_table :selections do |t|
      t.integer :user_id
      t.integer :vote_id
      t.text :answer

      t.timestamps
    end
  end
end
