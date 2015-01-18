class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  PROVIDER_KIND_NAMES = {
    google_oauth2: 'Google',
    windowslive:   'Windows Live',
  }.freeze

  User::OAUTH_INFOS.keys.each do |provider|
    kind_name = PROVIDER_KIND_NAMES[provider]
    class_eval %Q"
      def #{provider}
        @user = User.find_for_#{provider}(request.env['omniauth.auth'], current_user)

        if @user.persisted?
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: '#{kind_name}'
          sign_in_and_redirect @user, event: :authentication
        else
          flash[:alert] = I18n.t 'devise.omniauth_callbacks.failure', kind: '#{kind_name}', reason: @user.errors.full_messages
          redirect_to new_user_registration_url
        end
      end
    "
  end
end
