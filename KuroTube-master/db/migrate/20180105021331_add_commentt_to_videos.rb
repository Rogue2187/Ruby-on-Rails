class AddCommenttToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :comment, :text
  end
end
