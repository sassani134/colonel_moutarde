class NewGamesController < ApplicationController
  before_action :set_new_game, only: [:show, :edit, :update, :destroy]
  include Rails.application.routes.url_helpers

  # GET /new_games
  # GET /new_games.json
  def index
    if current_user.admin?
      @add_games = Game.order(:id)
    else
      redirect_to root_path
    end
  end

  # GET /new_games/1
  # GET /new_games/1.json
  def show
    if current_user.admin?
      @games= Game.find(params[:id])
    else
      redirect_to root_path
    end
  end

  # GET /new_games/new
  def new
    if user_signed_in?
      @new_game = Game.new
      @genre = Genre.all
      @style = Style.all
      @age = Age.all
      @player_number = PlayerNumber.all
    end
  end

  # GET /new_games/1/edit
  def edit
    if current_user.admin?
      @new_game = Game.find(params[:id])
    else
      redirect_to root_path
    end
  end

  # POST /new_games
  # POST /new_games.json
  def create
    if current_user.admin?
      @new_game = Game.new(title: params[:title], description: params[:description], confirm: true)
    elsif user_signed_in?
      @new_game = Game.new(title: params[:title], description: params[:description], confirm: false)
    else
      @new_game = Game.new
    end
    #image.attach(params[:image])
    respond_to do |format|
      if @new_game.save
        Category.create(game: @new_game, genre_id: params[:genre_id], style_id: params[:style_id], age_id: params[:age_id], player_number_id: params[:player_number_id])
        Game.last.image.attach(params[:image])
        
        format.html { redirect_to "/gameshow/#{Game.last.id}", notice: 'Crée avec succès' }
        format.json { render :show, status: :created, location: @new_game }
      else
        format.html { render :new }
        format.json { render json: @new_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /new_games/1
  # PATCH/PUT /new_games/1.json
  def update
    if current_user.admin?
      Game.find(params[:id]).image.purge
      @new_game = Game.find(params[:id])

      respond_to do |format|
        if @new_game.update(new_game_params)
          @new_game.confirm = true
          @new_game.save
          Game.find(params[:id]).categories[0].update( genre_id: params[:genre_id], style_id: params[:style_id], age_id: params[:age_id], player_number_id: params[:player_number_id])
          format.html { redirect_to "/gameshow/#{params[:id]}", notice: 'Jeu modifié avec succès' }
          format.json { render :show, status: :ok, location: @new_game }
        else
          format.html { render :edit }
          format.json { render json: @new_game.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  # DELETE /new_games/1
  # DELETE /new_games/1.json
  def destroy
    if current_user.admin?
      @new_game.destroy
      respond_to do |format|
        format.html { redirect_to new_games_url, notice: 'Jeu détruit avec succès.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_game
      #@add_game = AddGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def new_game_params
      params.require(:game).permit(:title, :description, :image )
    end
end
