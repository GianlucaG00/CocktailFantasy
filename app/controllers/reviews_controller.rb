class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  
  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
    id_bar = params[:bar_id]
    @bar = Bar.find(id_bar)
    @drinker = current_drinker
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
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

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
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
