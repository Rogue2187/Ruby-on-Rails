class AddUserIdVideoToVideos < ActiveRecord::Migration[5.1]
  def change
    add_index :videos, [:user_id, :video], unique: true
  end
end
