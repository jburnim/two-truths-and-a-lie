class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :name
      t.integer :lie

      t.string :statement1
      t.string :statement2
      t.string :statement3

      t.timestamps
    end
  end
end
