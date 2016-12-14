class UsersController < Devise::RegistrationsController


  def show
    authorize :user, :show?
  end

  def down_grade

    current_user.update_attribute(:role, 'standard')
    flash[:alert] = "You have downgraded your account, #{current_user.name}"
    redirect_to root_path

  end

end
