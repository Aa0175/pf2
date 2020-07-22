class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :content
      t.integer :post_id

      t.timestamps
    end
  end
end
