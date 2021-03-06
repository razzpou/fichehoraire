class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :redirect_to_sign_in
  before_filter :crypt_password_new_user

  private

  def crypt_password_new_user
    if request.fullpath == "/admin/users"
      if params
        if params[:user]
          if params[:user][:encrypted_password]
            params[:user][:encrypted_password] = BCrypt::Password.create(params[:user][:encrypted_password])
          end
        end
      end
    end
  end

  def redirect_to_sign_in # TODO don't work because can go anywhere
    if request.fullpath == "/" && !current_user
      redirect_to "/users/sign_in"
    end
  end

  #-> Prelang (user_login:devise)
  def require_user_signed_in
    unless user_signed_in?

      # If the user came from a page, we can send them back.  Otherwise, send
      # them to the root path.
      if request.env['HTTP_REFERER']
        fallback_redirect = :back
      elsif defined?(root_path)
        fallback_redirect = root_path
      else
        fallback_redirect = "/"
      end

      redirect_to fallback_redirect, flash: {error: "You must be signed in to view this page."}
    end
  end

end
