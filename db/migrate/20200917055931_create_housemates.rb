class CreateHousemates < ActiveRecord::Migration[6.0]
  def change
    create_table :housemates do |t|
      t.string :housemate, null: false, unique: true

      t.timestamps
    end
  end
end
