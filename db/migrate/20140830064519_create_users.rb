class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # Email is assed by device migration.
      t.string :name

      t.timestamps
    end
  end
end
