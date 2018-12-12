class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  def configure_permitted_parameters
	added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
	devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
	devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  helper_method :resource_name, :resource, :devise_mapping, :resource_class

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  module SharedComment
    def create
      if user_signed_in?
        @game = Game.find(params[:game_id])
        @comment = @game.comments.create!(comment_params)
      end
      redirect_to "/listing"
    end
   
    def comment_params
        params.require(:comment).permit(:user, :content)
    end
  end

end
