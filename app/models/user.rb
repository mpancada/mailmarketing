class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable # , :omniauthable

  MIN_PASSWORD_LENGTH = 8

  validates :password, presence: true, length: { minimum: MIN_PASSWORD_LENGTH }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  # Additional custom validation for password complexity
  validate :password_complexity

  private

  def password_complexity
    return if password.blank?

    unless password.match?(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\d\s]).{8,}$/)
      errors.add :password, "must include at least one lowercase letter, one uppercase letter, one digit, and one special character"
    end
  end
end
