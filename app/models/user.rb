class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :payments, class_name: "Transaction", foreign_key: "payer_id", dependent: :nullify, inverse_of: :payer
  has_many :receipts, class_name: "Transaction", foreign_key: "recipient_id", dependent: :nullify,
    inverse_of: :recipient

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable,
    omniauth_providers: %i[facebook]

  before_save :capitalize_name

  validates :first_name, :last_name, presence: true

  def admin?
    admin
  end

  def capitalize_name
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end

  def self.from_omniauth(auth)
    uid = auth.uid
    email = auth.info.email
    user = User.find_by(email:)

    if user
      user.update(uid: nil) unless user.uid == uid
      return user, uid
    end

    password = Devise.friendly_token[0, 20]
    first_name, *last_name = auth.info.name.split
    User.create!(email:, password:, first_name:, last_name: last_name.join(" "), provider: auth.provider, uid:)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
