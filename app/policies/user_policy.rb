class UserPolicy < ApplicationPolicy

attr_reader :user

  def initialize
    @user = user
  end

  def edit
    user.present
  end

  def update
    user.present?
  end

  def show
    user.present?
  end
  def new
    user.present?
  end

  def create
    user.present?
  end

end
