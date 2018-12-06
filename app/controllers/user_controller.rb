class UserController < ApplicationController
  def index
    @copies = current_user.copies
  end

  def add_game
    @games = Game.all
    @title=[]
    @games.each do |game|
      @title << game.title
    end
  end

  def save_game
  end
  
  def populate_form

    @visual = Visual.find_by_id(params[:emp_id])


    if @visual.present?
        respond_to do |format|
            @emp_first_name = @visual.first_name
            @emp_last_name = @visual.last_name
             render :json => {

                 :emp_first_name => @emp_first_name,
                 :emp_last_name => @emp_last_name
                              }
    else       
            format.js { render :json => "id not present", :status => 400 }
            format.html { render :json => "id not present" , :status => 400 }

         end    
     end
end

