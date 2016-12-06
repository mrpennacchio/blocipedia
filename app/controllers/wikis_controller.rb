class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def new
    #if current_user
    @wikis = Wiki.new
  end

  def show
     Rails.logger.info "************************"
     Rails.logger.info params[:id].inspect
    @wikis = Wiki.find(params[:id])
  end


  def create
    @wikis = Wiki.new(wiki_params)
    @wikis.user = current_user

    if @wikis.save
      flash[:notice] = "Wiki was saved."
      redirect_to wikis_path
    else
      flash[:error] = "Error. Could not save the wiki."
      render :new
    end
  end

  def edit
    #if current_user
  end

  def update
    # if current_user
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body )
  end
end
