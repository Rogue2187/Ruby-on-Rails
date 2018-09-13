class Video < ApplicationRecord

attr_accessor :results

# association
  belongs_to :user
  has_many :watches

# validation
  validates :user_id, uniqueness: { scope: [:video] }

# acts-as-taggable-on使用のための構文
  acts_as_taggable

# uploader用の構文
  mount_uploader :video, VideoUploader

end
