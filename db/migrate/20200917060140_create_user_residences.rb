class CreateUserResidences < ActiveRecord::Migration[6.0]
  def change
    create_table :user_residences do |t|
      t.references :user,       index: true, null: false, foreign_key: true
      t.references :residence,  index: true, null: false, foreign_key: true
      t.timestamps
    end
  end
end
