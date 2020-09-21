class AddAttributesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :age, :integer
    add_column :users, :height, :integer
    add_column :users, :weight, :float
    add_column :users, :job, :string
  end
end
