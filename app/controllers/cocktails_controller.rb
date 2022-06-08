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

  # GET /cocktails/1/edit
  def edit
  end

  # POST /cocktails or /cocktails.json
  def create
    #authorize! :create, @movie, :message => "Attenzione! Non sei autorizzato ad aggiungere nuovi Cocktail nel menù!"
    id_bar = params[:bar_id]
    @bar = Bar.find(id_bar)
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.bar = @bar
    authorize! :create, @cocktail, :message => "Attenzione! Non sei autorizzato ad aggiungere nuovi Cocktail nel menù!"
    if(@cocktail.save)
      redirect_to bar_path(@bar), notice: "Il cocktail #{@cocktail.name} per il menù del Bar '#{@bar.name}' è stato aggiunto con successo"
    else
      render :new, status: :unprocessable_entity
    end

    #@cocktail = Cocktail.new(cocktail_params)
    #respond_to do |format|
    #  if @cocktail.save
    #    format.html { redirect_to bar_cocktail_url(@cocktail), notice: "Il cocktail è stato aggiunto con successo" }
    #    format.json { render :show, status: :created, location: @cocktail }
    #    text = "Dai un'occhiata! E' stato aggiunto un cocktail nel menù: #{@cocktail.name}"
    #    Chat.select(:chat_id).find_by(bar_id: @cocktail.bar).each do |user|
    #      TelegramMailer.send_notification(text).deliver_now
    #    end 
    #  else
    #    format.html { render :new, status: :unprocessable_entity }
    #    format.json { render json: @cocktail.errors, status: :unprocessable_entity }
    #  end
  end

  # PATCH/PUT /cocktails/1 or /cocktails/1.json
  def update
    respond_to do |format|
      if @cocktail.update(cocktail_params)
        format.html { redirect_to cocktail_url(@cocktail), notice: "Il cocktail è stato modificato con successo" }
        format.json { render :show, status: :ok, location: @cocktail }
        text = "Dai un'occhiata! E' stato aggiunto un cocktail nel menù: #{@cocktail.name}"
        Chat.select(:chat_id).find_by(bar_id: @cocktail.bar).each do |user|
          TelegramMailer.send_notification(text).deliver_now
        end 
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cocktail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cocktails/1 or /cocktails/1.json
  def destroy
    # authorize! :destroy, @cocktail, :message => "Attenzione! Non sei autorizzato ad eliminare Cocktail dal menù!"
    @bar = @cocktail.bar
    @cocktail.destroy

    respond_to do |format|
      format.html { redirect_to @bar, notice: "Il cocktail è stato rimosso con successo" }
      format.json { head :no_content }

      #text = "Dai un'occhiata! E' stato aggiunto un cocktail nel menù: #{@cocktail.name}"
       # Chat.select(:chat_id).find_by(bar_id: @cocktail.bar).each do |user|
        #  TelegramMailer.send_notification(text).deliver_now
        #end 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cocktail
      @cocktail = Cocktail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cocktail_params
      params.require(:cocktail).permit(:name, :preparation, :ingredients, :price, :pic, :signature)
    end
end
