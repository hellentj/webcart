class User < ApplicationRecord
  #enum
  enum role: [:admin, :seller, :customer]
  enum status: [:unblock, :block]

  #devise_gem
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable,:omniauthable, :omniauth_providers => [:facebook]
         
  #relationships
  has_one :customer, dependent: :destroy
  has_one :seller, dependent: :destroy

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

end
