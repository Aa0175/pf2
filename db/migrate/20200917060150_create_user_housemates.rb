class CreateUserHousemates < ActiveRecord::Migration[6.0]
  def change
    create_table :user_housemates do |t|
      t.references :user,       index: true, null: false, foreign_key: true
      t.references :housemate,  index: true, null: false, foreign_key: true
      t.timestamps
    end
  end
end
