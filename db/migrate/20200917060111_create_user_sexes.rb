class CreateUserSexes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_sexes do |t|
      t.references :user, index: true, null: false, foreign_key: true
      t.references :sex,  index: true, null: false, foreign_key: true
      t.timestamps
    end
  end
end
