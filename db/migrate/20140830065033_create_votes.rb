class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :statement
      t.references :user, index: true
      t.references :round, index: true

      t.timestamps
    end

    add_index :votes, [:user_id, :round_id], unique: true
  end
end
