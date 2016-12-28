class CollaborationsController < ApplicationController

  def new
    @collaborations = Collaboration.new
    user = User.all
    authorize @collaborations
  end


  def create
    authorize :collaboration, :create?

    user_email = params[:email]
    user_id = User.where(email: user_email).pluck(:id)
    user = User.where(id: user_id)
    wiki = Wiki.find(params[:wiki_id])

    if @collaborations = wiki.collaborators << user
      flash[:notice] = "Collaborator Added"
    else
      flash[:alert] = "Collaborator unable to be added. Try again"
    end
      redirect_to wiki
  end

private
 def collaborator_params
    params.require(:collaborations).permit(:user_id, :wiki_id)
  end

end
