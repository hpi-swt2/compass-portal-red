# The model representing a user who can log in
class User < ApplicationRecord
  has_one :person, dependent: :nullify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[openid_connect]

  # Called from app/controllers/users/omniauth_callbacks_controller.rb
  # Match OpenID Connect data to a local user object
  def self.from_omniauth(auth)
    # Check if user with provider ('openid_connect') and uid is in db, otherwise create it
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      # All information returned by OpenID Connect is passed in `auth` param
      user.email = auth.info.email
      # Generate random password, default length is 20
      # https://www.rubydoc.info/github/plataformatec/devise/Devise.friendly_token
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name
      # `first_name` & `last_name` are also available
      # user.first_name = auth.info.first_names
      # user.last_name = auth.info.last_name
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
      connect_to_person(auth.info.email, user.id)
    end
  end

  # https://github.com/heartcombo/devise/wiki/OmniAuth:-Overview
  # Implement the following if you want to enable copying over data from an
  # OmniAuth provider after a user alsready has a session, i.e. is already logged in
  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if (data = session["devise.openid_connect_data"]) && user.email.blank?
  #       user.email = data["email"]
  #     end
  #   end
  # end

  def self.connect_to_person(email, id)
    address = email.gsub("@", "(at)")
    person = Person.find_by(email: address)
    address = address.gsub(".uni-potsdam.de", ".de")
    person ||= Person.find_by(email: address)
    return unless person

    person["user_id"] = id
    person.save
  end

end
