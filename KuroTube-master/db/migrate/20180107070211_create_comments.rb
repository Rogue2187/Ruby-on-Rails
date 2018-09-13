class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer     :video_id, null: false
      t.integer     :parent_comment_id
      t.integer     :children_number
      t.integer     :user_id, null: false
      t.text        :content, null: false
      t.boolean     :is_faved
      t.boolean     :is_pined
      t.timestamps
    end
  end
end
