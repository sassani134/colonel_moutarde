class NewGamesController < ApplicationController
  before_action :set_new_game, only: [:show, :edit, :update, :destroy]
  include Rails.application.routes.url_helpers

  # GET /new_games
  # GET /new_games.json
  def index
    @add_games = Game.order(:id)
  end

  # GET /new_games/1
  # GET /new_games/1.json
  def show
    @games= Game.find(params[:id])
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
    @new_game = Game.find(params[:id])
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
        format.html { redirect_to "/gameshow", notice: 'Add game was successfully created.' }
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
    respond_to do |format|
      if @new_game.update(Game.find(params[:id]))
        format.html { redirect_to @new_game, notice: 'Add game was successfully updated.' }
        format.json { render :show, status: :ok, location: @new_game }
      else
        format.html { render :edit }
        format.json { render json: @new_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /new_games/1
  # DELETE /new_games/1.json
  def destroy
    @new_game.destroy
    respond_to do |format|
      format.html { redirect_to new_games_url, notice: 'Add game was successfully destroyed.' }
      format.json { head :no_content }
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
