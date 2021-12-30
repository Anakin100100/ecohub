class AddAttributesToPsots < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :content, :text
  end
end
