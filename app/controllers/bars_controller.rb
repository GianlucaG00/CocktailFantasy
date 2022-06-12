class BarsController < ApplicationController
  before_action :authenticate_barman!, only: %i[new edit update destroy ]
  before_action :set_bar, only: %i[ show edit update destroy ] 
  
  # CRUD operations
  # GET /bars or /bars.json
  def index
    @bars = Bar.search(params[:search], params[:type])
    if @bars.size == 0
      flash[:message] = "Spiacente, la ricerca non ha prodotto alcun risultato"
    end
  end

  # GET /bars/1 or /bars/1.json
  def show
    id_bar = params[:id] # bars/:id
    @bar = Bar.find(id_bar)
    @cocktails = Cocktail.where(bar_id: id_bar)
    @reviews = Review.where(bar_id: id_bar)
    @num_sub = Chat.where(bar_id: id_bar).size
  end

  # GET /bars/new
  def new
    if(!(barman_signed_in?))
      flash[:message] = "Attenzione! Solo il Barman proprietario può modificare l'annuncio"
      redirect_to bars_path
      return
    end
    @bar = Bar.new
  end

  # GET /bars/1/edit
  def edit
    if(!(barman_signed_in?))
      flash[:message] = "Attenzione! Solo il Barman proprietario può modificare l'annuncio"
      redirect_to bars_path
      return
    end
    barman_id = current_barman.id # id Barman Loggato 
    if(barman_id != @bar.barman_id)
      flash[:message] = "Attenzione! Solo il Barman proprietario può modificare l'annuncio"
      redirect_to bars_path
    end
  end

  # POST /bars or /bars.json
  def create
    if(!(barman_signed_in?))
      flash[:message] = "Attenzione! Solo i Barman possono creare annunci"
      redirect_to bars_path
      return
    end


    @bar = Bar.new(bar_params)
    @bar.barman = current_barman

    respond_to do |format|
      if @bar.save
        format.html { redirect_to bar_url(@bar), notice: "Il Bar è stato correttamente creato" }
        format.json { render :show, status: :created, location: @bar }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bars/1 or /bars/1.json
  def update
    if(!(barman_signed_in?))
      flash[:message] = "Attenzione! Solo il Barman proprietario può modificare l'annuncio"
      redirect_to bars_path
      return
    end
    barman_id = current_barman.id # id Barman Loggato 
    if(barman_id != @bar.barman_id)
      flash[:message] = "Attenzione! Solo il Barman proprietario può modificare l'annuncio"
      redirect_to bars_path
      return
    end


    respond_to do |format|
      if @bar.update(bar_params)
        format.html { redirect_to bar_url(@bar), notice: "Il Bar è stato aggiornato con successo." }
        format.json { render :show, status: :ok, location: @bar }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bars/1 or /bars/1.json
  def destroy
    if(!(barman_signed_in?))
      flash[:message] = "Attenzione! Solo il Barman proprietario può eliminare l'annuncio"
      redirect_to bars_path
      return
    end
    barman_id = current_barman.id # id Barman Loggato 
    if(barman_id != @bar.barman_id)
      flash[:message] = "Attenzione! Solo il Barman proprietario può eliminare l'annuncio"
      redirect_to bars_path
      return
    end
    @bar.destroy
    respond_to do |format|
      format.html { redirect_to barmen_personalArea_path, notice: "Il Bar è stato eliminato con successo" }
      flash[:message] = "Il Bar è stato rimosso con successo"; 
      format.json { head :no_content }
    end
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_bar
      @bar = Bar.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bar_params
      params.require(:bar).permit(:name, :description, :address, :tel, :pic, :regione)
    end
end
