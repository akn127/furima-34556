class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  with_options presence: true do
    validates :nickname
    validates :family_name
    validates :first_name
    validates :kana_family_name
    validates :kana_first_name
    validates :birth_date
  end

  
  PASSWORD_REGEX = /(?=.*?[a-z])(?=.*?[\d])[a-z\d]{6,}/i

  validates :family_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: "Full-width characters"}
  validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: "Full-width characters"}
  validates :kana_family_name, format: { with: /\A[ァ-ヶ一]+\z/, message: "Full-width katakana characters"}
  validates :kana_first_name, format: { with: /\A[ァ-ヶ一]+\z/, message: "Full-width katakana characters"}
  validates :password, format: { with: PASSWORD_REGEX, message: "Include both letters and numbers"}
end
