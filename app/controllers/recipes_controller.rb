class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @recipe.publication = Publication.new
  end

  def new_publication
    respond_to do |format|
      format.js
    end
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(params_for_create)

    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /recipes/1
  def update
    if @recipe.update(params_for_update)
      redirect_to @recipe, notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy
    redirect_to recipes_url, notice: 'Recipe was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def params_for_update
    params.require(:recipe).permit(:name)
  end

  def params_for_create
    params.require(:recipe).permit(:name, :page_number,
                                   publication_attributes: [:name, :author])
  end
end
