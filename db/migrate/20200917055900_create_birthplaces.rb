class CreateBirthplaces < ActiveRecord::Migration[6.0]
  def change
    create_table :birthplaces do |t|
      t.string :birthplace, null: false, unique: true

      t.timestamps
    end
  end
end
