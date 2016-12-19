class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable

  has_many :wikis, dependent: :destroy

  # automatically regieser user as a standard user
  after_initialize :init_role

  # email is downcase and will send after creation of new user
  before_save { self.email = email.downcase if email.present? }
  # after_create :send_confirmation_email

  # user validations
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  # enum :standard = 0, :admin = 1, :premium = 2
  enum role: [:standard, :admin, :premium]

  def init_role
    self.role ||= :standard
  end


  def self.downgrade(user)
    self.roles ==  'standard'
    Wiki.make_public(user)
  end

end
