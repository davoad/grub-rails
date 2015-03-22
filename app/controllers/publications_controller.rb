class PublicationsController < ApplicationController
  before_action :set_publication, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /publications
  def index
    @publications = Publication.order('LOWER(name)')
  end

  # GET /publications/1
  def show
  end

  # GET /publications/new
  def new
    @publication = Publication.new
  end

  # GET /publications/1/edit
  def edit
  end

  # POST /publications
  def create
    @publication = Publication.new(params_for_create)
    if @publication.save
      redirect_to @publication, notice: 'Publication was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /publicationa/1
  def update
    if @publication.update(params_for_update)
      redirect_to @publication, notice: 'Publication was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /publications/1
  def destroy
    @publication.destroy
    redirect_to publications_url, notice: 'Publication was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_publication
    @publication = Publication.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def params_for_update
    params.require(:publication).permit(:name, :author, :edition)
  end

  def params_for_create
    params.require(:publication).permit(:name, :author, :edition)
  end
end
