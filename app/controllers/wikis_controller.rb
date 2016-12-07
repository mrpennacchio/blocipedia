class WikisController < ApplicationController

  before_action :authorize_user, except: [:index, :show]
  def index
    #anyone
    @wikis = Wiki.all
  end

  def show
    #anyone
    @wikis = Wiki.find(params[:id])
  end

  def new
    #if current_user
    @wikis = Wiki.new
  end

  def create
    # if current User
    @wikis = Wiki.new(wiki_params)
    @wikis.user = current_user

    if @wikis.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wikis
    else
      flash[:error] = "Error. Could not save the wiki."
      render :new
    end
  end

  def edit
    # if current user
    @wikis = Wiki.find(params[:id])
  end

  def update
    # if current_user

    @wikis = Wiki.find(params[:id])
    @wikis.title = params[:wiki][:title]
    @wikis.body = params[:wiki][:body]

    if @wikis.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wikis
    else
      flash.now[:alert] = "There was an error updating this wiki. Try again."
      render :edit
    end
  end


  def destroy
    @wikis = Wiki.find(params[:id])

    if @wikis.destroy
      flash[:notice] = "\"#{@wikis.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting your wiki. Try again."
      render :show
    end
  end


  private


  def authorize_user
    # @wikis = Wiki.find(params[:id])
    unless current_user
      flash[:alert]= "You must be logged in to do that. Sign up or log in now!"
      redirect_to root_path
    end

  end

  def wiki_params
    params.require(:wiki).permit(:title, :body )
  end
end
