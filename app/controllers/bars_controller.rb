class BarsController < ApplicationController
  before_action :authenticate_barman!, only: %i[new edit update destroy ]
  before_action :set_bar, only: %i[ show edit update destroy ] 
  
  # CRUD operations
  # GET /bars or /bars.json
  def index
    @bars = Bar.all
  end

  # GET /bars/1 or /bars/1.json
  def show
    id_bar = params[:id] # bars/:id
    @bar = Bar.find(id_bar)
    @cocktails = Cocktail.where(bar_id: id_bar)
    @reviews = Review.where(bar_id: id_bar)
  end

  # GET /bars/new
  def new
    @bar = Bar.new
    #authorize! :create, @bar, :message => "Attenzione! Non sei autorizzato a creare annunci di Bar!"
  end

  # GET /bars/1/edit
  def edit
    #authorize! :update, @bar, :message => "Attenzione! Non sei autorizzato a modificare annunci di Bar!"
  end

  # POST /bars or /bars.json
  def create
    @bar = Bar.new(bar_params)
    authorize! :create, @bar, :message => "Attenzione! Non sei autorizzato a creare annunci di Bar!"
    @bar.barman = current_barman

    respond_to do |format|
      if @bar.save
        format.html { redirect_to bar_url(@bar), notice: "Il Bar è stato correttamente inserito" }
        format.json { render :show, status: :created, location: @bar }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bars/1 or /bars/1.json
  def update
    #authorize! :update, @bar, :message => "Attenzione: non sei autorizzato a modificare annunci di Bar!"
    respond_to do |format|
      if @bar.update(bar_params)
        format.html { redirect_to bar_url(@bar), notice: "Bar was successfully updated." }
        format.json { render :show, status: :ok, location: @bar }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bars/1 or /bars/1.json
  def destroy
    #authorize! :destroy, @bar, :message => "Attenzione: non sei autorizzato a cancellare annunci di Bar!"

    @bar.destroy
    respond_to do |format|
      format.html { redirect_to bars_url, notice: "Bar was successfully destroyed." }
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
      params.require(:bar).permit(:name, :description, :address, :tel)
    end
end
