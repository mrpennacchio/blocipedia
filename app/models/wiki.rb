class Wiki < ApplicationRecord
  belongs_to :user

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true

  validates :user, presence: true

  # check to see if a user is present of signed in.
  # If it is a premium or admin user, show all. Else, show all wikis that are public
  scope :visible_to, -> (user){ user && ((user.premium?) || (user.admin?)) ? where(private: false) + where(private: true, user: user) : where(private: false) }

  # make private wikis public
  def self.make_public(user)
    user.wikis.each do |w|
      w.update_attribute :private, false
    end
  end

end
