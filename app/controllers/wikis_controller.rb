class WikisController < ApplicationController
include ApplicationHelper
  # before_action :authorize_user, except: [:index, :show]
  def index
    #anyone
    @wiki = policy_scope(Wiki)
  end

  def show
    #anyone
    @wiki = Wiki.find(params[:id])
  end

  def new
    #if current_user
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    # if current User
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "Error. Could not save the wiki."
      render :new
    end
  end

  def edit
    # if current user
    @wiki = Wiki.find(params[:id])
    authorize @wiki

  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:title]
    @wiki.body = params[:body]
    # @wiki.private = params[:wiki][:private]

    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating this wiki. Try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting your wiki. Try again."
      render :show
    end
  end

  def add_collaborator
    authorize :collaboration, :create?

    user_email = params[:email]
    user_id = User.where(email: user_email).pluck(:id)
    user = User.where(id: user_id)
    @wiki = Wiki.find(params[:id])

    if collaborations = @wiki.collaborators << user && user.exists?
      flash[:notice] = "Collaborator Added"
    elsif @wiki.collaborators.exists?
      flash[:alert] = "Collaborator already exists."
    else
      flash[:alert] = "Collaborator unable to be added. Try again"
    end
    redirect_to @wiki
  end

  def remove_collaborator
    wiki = Wiki.find(params[:id])
    authorize :collaboration, :destroy?

    # user_id
    collaborator_id = params[:collaborator_id]
    # remove user from wiki.collaborators array

      if collaborations.destroy
        flash[:notice] = "Collaborator Removed"
      else
        flash[:alert] = "Collaborator not removed. Try again"
      end
        redirect_to @wiki
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
    params.require(:wiki).permit(:title, :body, :private )
  end

end
