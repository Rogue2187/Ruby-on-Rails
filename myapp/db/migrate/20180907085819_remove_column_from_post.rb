class RemoveColumnFromPost < ActiveRecord::Migration
  def change
  	remove_column :posts, :name, :string
  end
end
