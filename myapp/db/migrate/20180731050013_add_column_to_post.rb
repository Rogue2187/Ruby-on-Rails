class AddColumnToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :place, :string
  end
end
