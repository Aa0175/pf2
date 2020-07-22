class CreateNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :nodes do |t|
      t.integer :post_id
      t.string :content
      t.integer :parent_id

      t.timestamps
    end
  end
end
