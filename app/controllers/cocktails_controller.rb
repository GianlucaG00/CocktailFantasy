class CocktailsController < ApplicationController
  before_action :set_cocktail, only: %i[ show edit update destroy ]

  # per la richiesta API a CocktailDB
  def search_cocktail
    response = HTTParty.get("http://thecocktaildb.com/api/json/v1/1/search.php?s=margarita")
    @array = JSON.parse(response)
  end
  helper_method :search_cocktail

  # CRUD operations
  # GET /cocktails or /cocktails.json
  def index
    @cocktails = Cocktail.all
  end

  # GET /cocktails/1 or /cocktails/1.json
  def show
  end

  # GET /cocktails/new
  def new
    @cocktail = Cocktail.new
  end

  # GET /cocktails/1/edit
  def edit
  end

  # POST /cocktails or /cocktails.json
  def create
    @cocktail = Cocktail.new(cocktail_params)

    respond_to do |format|
      if @cocktail.save
        format.html { redirect_to cocktail_url(@cocktail), notice: "Cocktail was successfully created." }
        format.json { render :show, status: :created, location: @cocktail }
        text = "E' stato aggiunto un cocktail nel menù: #{@cocktail.name}"
        TelegramMailer.send_notification(text).deliver_now
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cocktail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cocktails/1 or /cocktails/1.json
  def update
    respond_to do |format|
      if @cocktail.update(cocktail_params)
        format.html { redirect_to cocktail_url(@cocktail), notice: "Cocktail was successfully updated." }
        format.json { render :show, status: :ok, location: @cocktail }
        text = "E' stato aggiornato un cocktail nel menù: #{@cocktail.name}"
        TelegramMailer.send_notification(text).deliver_now
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cocktail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cocktails/1 or /cocktails/1.json
  def destroy
    @cocktail.destroy

    respond_to do |format|
      format.html { redirect_to cocktails_url, notice: "Cocktail was successfully destroyed." }
      format.json { head :no_content }
      text = "E' stato elimiato un cocktail nel menù: #{@cocktail.name}"
      TelegramMailer.send_notification(text).deliver_now
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cocktail
      @cocktail = Cocktail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cocktail_params
      params.require(:cocktail).permit(:name, :preparation, :ingredients, :price)
    end
end
