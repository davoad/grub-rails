class User < ActiveRecord::Base
  devise :rememberable, :omniauthable, omniauth_providers: [:google_oauth2, :windowslive]
  has_many :ratings
  has_many :recipes, through: :ratings

  OAUTH_INFOS = {
    google_oauth2: {
      email:      'data.info.email',
      first_name: 'data.info.first_name',
      last_name:  'data.info.last_name'
    }.freeze,
    windowslive: {
      email:      'data.extra.raw_info.emails.preferred',
      first_name: 'data.extra.raw_info.first_name',
      last_name:  'data.extra.raw_info.last_name'
    }.freeze
  }.freeze

  class << self
    OAUTH_INFOS.each do |provider, infos|
      class_eval %"
        def find_for_#{provider}(data, signed_in_resource=nil)
          where(email: #{infos[:email]}).first do |u|
            u.provider   = '#{provider}'
            u.first_name = #{infos[:first_name]}.presence || 'John'
            u.last_name  = #{infos[:last_name]}.presence  || 'Do'
            u.encrypted_password   = Devise.friendly_token[0,20]
          end
        end
      "
    end
  end
end
