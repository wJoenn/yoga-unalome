class User < ApplicationRecord
  has_many :bookings, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]

  before_save :capitalize_name, unless: :admin?

  validates :first_name, :last_name, presence: true, unless: :admin?

  def admin?
    admin
  end

  def capitalize_name
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end

  def self.from_omniauth(auth)
    first_name, *last_name = auth.info.name.split
    email = auth.info.email
    user = User.where(email:).first
    return user if user

    password = Devise.friendly_token[0, 20]
    last_name = last_name.join(" ")
    provider = auth.provider
    uid = auth.uid
    User.create!(email:, password:, first_name:, last_name:, provider:, uid:)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
