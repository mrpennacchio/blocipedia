class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, record)
  @user = user
  @record = record
end



  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def edit?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
     user.role == "admin" || record.user == user
  end
end
