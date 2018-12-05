class AddGamesController < ApplicationController
  before_action :set_add_game, only: [:show, :edit, :update, :destroy]

  # GET /add_games
  # GET /add_games.json
  def index
    @add_games = Game.all
  end

  # GET /add_games/1
  # GET /add_games/1.json
  def show
    @games = Game.last
  end

  # GET /add_games/new
  def new
    @add_game = Game.new
  end

  # GET /add_games/1/edit
  def edit
  end

  # POST /add_games
  # POST /add_games.json
  def create
    @add_game = Game.new(title: params[:title], description: params[:description])   
    respond_to do |format|
      if @add_game.save
        Game.last.image.attach(params[:image])
        format.html { redirect_to "/gameshow", notice: 'Add game was successfully created.' }
        format.json { render :show, status: :created, location: @add_game }
      else
        format.html { render :new }
        format.json { render json: @add_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /add_games/1
  # PATCH/PUT /add_games/1.json
  def update
    respond_to do |format|
      if @add_game.update(add_game_params)
        format.html { redirect_to @add_game, notice: 'Add game was successfully updated.' }
        format.json { render :show, status: :ok, location: @add_game }
      else
        format.html { render :edit }
        format.json { render json: @add_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /add_games/1
  # DELETE /add_games/1.json
  def destroy
    @add_game.destroy
    respond_to do |format|
      format.html { redirect_to add_games_url, notice: 'Add game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_add_game
      #@add_game = AddGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def add_game_params
      params.require(:game).permit(:title, :description, :image )
    end
end
