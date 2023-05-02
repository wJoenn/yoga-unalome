class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  before_save :capitalize_name

  validates :first_name, :last_name, presence: true
  validates :email, format: { with: /\A[\w\d]+(?:[._-]?[\w\d]+)*@[\w\d]+(?:[.-]?[\w\d]+)*(?:\.\w{2,})+\z/ }

  def admin?
    admin
  end

  def capitalize_name
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
