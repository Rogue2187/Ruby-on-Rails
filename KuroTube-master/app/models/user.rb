class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :videos
  has_many :watches


  def self.find_for_google_oauth2(auth)
    user = User.where(email: auth.info.email).first

    unless user
      user = User.create(name:      auth.info.name,
                         provider:  auth.provider,
                         uid:       auth.uid,
                         email:     auth.info.email,
                         image_url: auth.info.image,
                         token:     auth.credentials.token,
                         password:  Devise.friendly_token[0, 20])
    end
    user
  end

  has_many :comments
end
