class User < ActiveRecord::Base
  # Connects this user object to Hydra behaviors.
  include Hydra::User# Connects this user object to Sufia behaviors. 
  include Sufia::User
  include Sufia::UserUsageStats

  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
      data = access_token.info
      # @user = User.find_or_create_by(email: data['email'])
      @user = User.find_by(email: data['email'])
      # XXX Find better place to put this e.g. omniauth_callbacks_controller.rb
      @user.avatar_file_name = data['image'];
      @user.save 
      return @user
  end

  def audituser
    User.find_by_user_key(audituser_key)
  end

  def batchuser
    User.find_by_user_key(batchuser_key)
  end


  if Blacklight::Utils.needs_attr_accessible?

    attr_accessible :email
  end
# Connects this user object to Blacklights Bookmarks. 
  include Blacklight::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :rememberable, :trackable

  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end
end
