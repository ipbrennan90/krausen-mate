class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.integer :parent_id 
      
      t.timestamps
    end

  end
end
