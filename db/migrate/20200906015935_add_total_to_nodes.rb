class AddTotalToNodes < ActiveRecord::Migration[6.0]
  def change
    add_column :nodes, :total, :int, null: false, default: 0
  end
end
