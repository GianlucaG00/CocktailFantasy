class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews/new
  def new
    if(!(drinker_signed_in?))
      flash[:message] = "Attenzione! Solo i Drinker possono lasciare recensioni!"
      redirect_to bars_path
      return
    end
    @review = Review.new
    id_bar = params[:bar_id]
    @bar = Bar.find(id_bar)
    @drinker = current_drinker
  end

  # POST /reviews or /reviews.json
  def create
    if(!(drinker_signed_in?))
      flash[:message] = "Attenzione! Solo i Drinker possono lasciare recensioni!"
      redirect_to bars_path
      return
    end
    @review = Review.new(review_params)
    bar_id = params[:bar_id]
    @bar = Bar.find(bar_id)
    @review.drinker = current_drinker
    @review.bar = @bar
    if @review.save
      redirect_to bar_path(@bar), notice: "La recensione per il Bar '#{@bar.name}' è stato aggiunta con successo"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    if(!(drinker_signed_in?))
      flash[:message] = "Attenzione! Solo il Drinker proprietario può eliminare la recensione!"
      redirect_to bars_path
      return
    end
    drinker_id = current_drinker.id # id Barman Loggato 
    if(drinker_id != @review.drinker_id)
      flash[:message] = "Attenzione! Solo il Drinker proprietario può eliminare la recensione!"
      redirect_to :back
    end

    @review.destroy
    respond_to do |format|
      if drinker_signed_in?
        format.html { redirect_to drinkers_personalArea_path, notice: "La recensione è stata eliminata con successo" }
        format.json { head :no_content }
      else
        format.html { redirect_to bars_path, notice: "La recensione è stata eliminata con successo" }
        format.json { head :no_content }
      end 
    end
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:text, :vote, :drinker_id, :bar_id)
    end
end
