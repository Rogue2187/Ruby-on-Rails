class CreateWatches < ActiveRecord::Migration[5.1]
  def change
    create_table :watches do |t|
      t.references :user, foreign_key: true, null:false
      t.references :video, foreign_key: true, null:false
      t.timestamps
    end
  end
end
