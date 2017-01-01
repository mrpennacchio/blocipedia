class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable

  has_many :wikis, dependent: :destroy
  # u.wikis
  # u.collaborating_wikis << wikis
  has_many :collaborations
  has_many :collaborating_wikis, through: :collaborations, source: :wiki

  # automatically regieser user as a standard user
  after_initialize :init_role


  # user validations
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :email, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  # enum :standard = 0, :admin = 1, :premium = 2
  enum role: [:standard, :admin, :premium]

  def init_role
    self.role ||= :standard
  end

  def downgrade
    self.role = "standard"
    wikis.each do |wiki|
      wiki.make_public
    end
    save
  end


end
