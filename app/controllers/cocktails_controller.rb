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
    id_bar = params[:bar_id]
    @bar = Bar.find(id_bar)
    @cocktail = @bar.cocktails.build
    #authorize! :create, @cocktail, :message => "Attenzione! Non sei autorizzato ad aggiungere nuovi Cocktail!"
  end


  # POST /cocktails or /cocktails.json
  def create
    id_bar = params[:bar_id]
    @bar = Bar.find(id_bar)
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.bar = @bar
    if(@cocktail.save)
      text = "Dai un'occhiata! E' stato aggiunto il cocktail #{@cocktail.name} nel menù di #{@cocktail.bar.name}!"
      Chat.where(bar_id: id_bar).each do |chat|
        chat_id = Drinker.find(chat.drinker_id).chat_id
        TelegramMailer.send_notification(text, chat_id).deliver_now
      end 
      redirect_to bar_path(@bar), notice: "Il cocktail #{@cocktail.name} per il menù del Bar '#{@bar.name}' è stato aggiunto con successo"
    else
      render :new, status: :unprocessable_entity
    end
  end


  # DELETE /cocktails/1 or /cocktails/1.json
  def destroy
    @bar = @cocktail.bar
    @name = @cocktail.name
    @cocktail.destroy

    id_bar = @bar.id
    respond_to do |format|
      format.html { redirect_to @bar, notice: "Il cocktail #{@name}è stato rimosso con successo" }
      format.json { head :no_content }
      text = "Ci dispiace! E' stato rimosso il cocktail #{@cocktail.name} dal menù di #{@cocktail.bar.name}!"
      Chat.where(bar_id: id_bar).each do |chat|
        chat_id = Drinker.find(chat.drinker_id).chat_id
        TelegramMailer.send_notification(text, chat_id).deliver_now
      end 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cocktail
      @cocktail = Cocktail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cocktail_params
      params.require(:cocktail).permit(:name, :preparation, :ingredients, :price, :pic, :signature, :ingredients)
    end
end
