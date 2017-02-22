class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.text :question
      t.text :first_answer
      t.text :second_answer
      t.integer :first_count
      t.integer :second_count
      t.integer :user_id
      
      t.timestamps
    end
  end
end
