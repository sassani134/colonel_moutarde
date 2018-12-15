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
      @game = Game.find(params[:game_id])
      @comment = Comment.new(user:current_user, game: @game, content: params[:comment][:content])
      if @comment.save
        redirect_back(fallback_location: root_path)
      else 
        redirect_back(fallback_location: root_path)
        flash[:alert] = "Le commentaire n'a pas pu être enregistré"
      end
    end
   
    def destroy
      @game = Game.find(params[:game_id])
      @comment = @game.comments.find(params[:id])
      if @comment.user_id == current_user.id
          @comment.destroy
          redirect_back(fallback_location: root_path)
          flash[:alert] = "Commentaire supprimé"
      else
        redirect_back(fallback_location: root_path)
        flash[:alert] = "Vous ne pouvez pas supprimer ce commentaire"
      end
    end
    
  end

end
