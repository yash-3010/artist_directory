# frozen_string_literal: true

# This is user model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 0, admin: 1 }

  # Strong password validation format
  validates :password,
            format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}\z/,
                      message: 'must contain at least one uppercase letter, one lowercase
                       letter, one number, and one special character' }, if: :password_required?

  has_many :comments, dependent: :destroy

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end

  private

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

end
