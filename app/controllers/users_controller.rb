class UsersController < Devise::RegistrationsController

  # attr_accessor :wikis

  def show
    authorize :user, :show?
  end

  def down_grade
    @user = current_user
    @user.update_attribute :role, 'standard'
    @user = User.downgrade(@user)
    flash[:alert] = "You have downgraded your account, #{current_user.name}. Your private wikis are now public"
    redirect_to root_path

  end

end
