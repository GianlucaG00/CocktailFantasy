class CocktailsController < ApplicationController
  before_action :set_cocktail, only: %i[ show edit update destroy ]

  # per la richiesta API a CocktailDB
  # da eliminare !!!
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
    if(!(barman_signed_in?))
      flash[:message] = "Attenzione! Solo il Barman proprietario può creare nuovi cocktail!"
      redirect_to bars_path
      return
    end
    id_bar = params[:bar_id] # id bar 
    @bar = Bar.find(id_bar)
    id_barman = current_barman.id # id Barman loggato
    if(@bar.barman_id != id_barman)
      flash[:message] = "Attenzione! Solo il Barman proprietario può creare nuovi cocktail!"
      redirect_to bars_path
      return
    end
    @cocktail = @bar.cocktails.build
  end


  # POST /cocktails or /cocktails.json
  def create
    if(!(barman_signed_in?))
      flash[:message] = "Attenzione! Solo il Barman proprietario può creare nuovi cocktail!"
      redirect_to bars_path
      return
    end
    id_bar = params[:bar_id]
    @bar = Bar.find(id_bar)
    id_barman = current_barman.id
    if(@bar.barman_id != id_barman)
      flash[:message] = "Attenzione! Solo il Barman proprietario può creare nuovi cocktail!"
      redirect_to bars_path
      return
    end

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
    if(!(barman_signed_in?))
      flash[:message] = "Attenzione! Solo il Barman proprietario può eliminare cocktail dal menù!"
      redirect_to @cocktail.bar
      return
    end
    barman_id = current_barman.id # id Barman Loggato
    if(barman_id != @cocktail.bar.barman_id)
      flash[:message] = "Attenzione! Non sei autorizzato ad eliminare cocktail dal menù di altri Barman"
      redirect_to @cocktail.bar
    end

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
