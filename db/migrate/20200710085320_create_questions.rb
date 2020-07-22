class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :post_id
      t.integer :answer_id
      t.string :content

      t.timestamps
    end
  end
end
