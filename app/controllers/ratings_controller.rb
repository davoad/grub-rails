class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /ratings
  def index
    @ratings = Rating.all
  end

  # GET /ratings/1
  def show
  end

  # GET /ratings/new
  def new
    @rating = Rating.new
  end

  # GET /ratings/1/edit
  def edit
  end

  # POST /ratings
  def create
    @rating = Rating.new(params_for_create)
    @rating.user = current_user
    if @rating.save
      redirect_to controller: :recipes, action: :show, id: @rating.recipe_id
    else
      render :new
    end
  end

  # PATCH/PUT /ratings/1
  def update
    if @rating.user_id != current_user.id
      render :edit, notice: 'You do not have permission to edit this Rating!'
    elsif @rating.update(params_for_update)
      redirect_to controller: :recipes, action: :show, id: @rating.recipe_id
    else
      render :edit
    end
  end

  # DELETE /ratings/1
  def destroy
    @rating.destroy
    redirect_to ratings_url, notice: 'Rating was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rating
    @rating = Rating.find_by(id: params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def params_for_update
    params.require(:rating).permit(:id, :title, :value, :comments)
  end

  def params_for_create
    params.require(:rating).permit(:title, :value, :comments, :recipe_id)
  end
end
