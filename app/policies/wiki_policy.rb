class WikiPolicy < ApplicationPolicy

  def new?
    create?
  end

  def create?
    user.present?
  end

  def destroy?
    record.user == user || record.user.role == "admin"
  end
end
