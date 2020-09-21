class CreateSexes < ActiveRecord::Migration[6.0]
  def change
    create_table :sexes do |t|
      t.string :sex, null: false, unique: true

      t.timestamps
    end
  end
end
