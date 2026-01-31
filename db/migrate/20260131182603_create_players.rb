class CreatePlayers < ActiveRecord::Migration[8.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :number
      t.string :position
      t.string :college
      t.integer :exp

      t.timestamps
    end
  end
end
