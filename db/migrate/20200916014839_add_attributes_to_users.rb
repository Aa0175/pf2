class AddAttributesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :age, :integer
    add_column :users, :sex, :string
    add_column :users, :height, :integer
    add_column :users, :weight, :float
    add_column :users, :birthplace, :string
    add_column :users, :residence, :string
    add_column :users, :job, :string
    add_column :users, :live_with, :string
  end
end
