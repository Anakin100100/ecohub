class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.timestamps
      t.belongs_to :user
      t.string :name, null: false
      t.text :text, null: false
    end

    create_table :ingredients do |t|
      t.timestamps
      t.belongs_to :user
      t.string :name, null: false
      t.integer :weight, null: false
      t.integer :price, null: false
      t.boolean :is_trash, null: false
    end

    create_table :lists do |t|
      t.timestamps
      t.belongs_to :user
      t.string :name, null: false
    end

    create_table :ingredients_recipes, id: false do |t|
      t.belongs_to :recipe
      t.belongs_to :ingredient 
    end

    create_table :ingredients_lists, id: false do |t|
      t.belongs_to :list
      t.belongs_to :ingredient 
    end

    create_table :lists_recipes, id: false do |t|
      t.belongs_to :list
      t.belongs_to :recipe 
    end
  end
end
