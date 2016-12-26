class UsersController < Devise::RegistrationsController

  # attr_accessor :wikis


  def show
    authorize :user, :show?
  end

  def down_grade
    current_user.downgrade
    flash[:alert] = "You have downgraded your account, #{current_user.name}. Your private wikis are now public"
    redirect_to root_path

  end

end
