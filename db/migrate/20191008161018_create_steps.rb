class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.string :title
      t.integer :step_number
      t.text :content
      t.integer :recipe_id
      t.integer :parent_id 
      
      t.timestamps
    end
  end
end
