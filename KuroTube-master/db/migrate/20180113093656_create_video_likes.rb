class CreateVideoLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :video_likes do |t|
      t.integer     :video_id, null: false
      t.integer     :user_id, null: false
      t.string      :like_state, null: false
    end
  end
end
