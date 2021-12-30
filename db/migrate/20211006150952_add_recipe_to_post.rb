class AddRecipeToPost < ActiveRecord::Migration[6.1]
  def change
    add_reference(:posts, :recipe, foreign_key: true)
  end
end
