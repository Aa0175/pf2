class CreateResidences < ActiveRecord::Migration[6.0]
  def change
    create_table :residences do |t|
      t.string :residence, null: false, unique: true

      t.timestamps
    end
  end
end
