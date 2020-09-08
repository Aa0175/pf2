class AddTotalToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :total, :int, null: false, default: 0
  end
end
