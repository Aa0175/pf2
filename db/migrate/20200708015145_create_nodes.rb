class CreateNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :nodes do |t|
      t.integer :post_id
      t.integer :node_id
      t.string :content

      t.timestamps
    end
  end
end
