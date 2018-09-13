class AddCountToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :count, :integer
  end
end
