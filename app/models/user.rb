class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  with_options presence: true do
    validates :nickname
    validates :family_name
    validates :first_name
    validates :kana_family_name
    validates :kana_first_name
    validates :birth_date
  end

  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'Full-width characters' } do
    validates :family_name
    validates :first_name
  end

  with_options format: { with: /\A[ァ-ヶ一]+\z/, message: 'Full-width katakana characters' } do
    validates :kana_family_name
    validates :kana_first_name
  end

  PASSWORD_REGEX = /(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}/i
  validates :password, format: { with: PASSWORD_REGEX, message: 'Include both letters and numbers' }
end
