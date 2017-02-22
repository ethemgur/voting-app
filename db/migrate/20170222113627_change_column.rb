class ChangeColumn < ActiveRecord::Migration[5.0]
  def change
    change_column :votes, :first_count, :integer, :default => 0
    change_column :votes, :second_count, :integer, :default => 0
  end
end
