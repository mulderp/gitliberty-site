class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider, type: String
  field :uid,      type: String
  field :name,     type: String
  field :profile,  type: String
  field :avatar,   type: String

  def self.from_omniauth(auth)
    where(auth.slice('provider', 'uid')).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid      = auth['uid']
      user.name     = auth['info']['name']
      user.profile  = auth['info']['urls']['GitHub']
      user.avatar   = auth['info']['image']
    end
  end
end
