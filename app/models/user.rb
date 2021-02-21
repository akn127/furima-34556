class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  PASSWORD_REGEX = /(?=.*?[a-z])(?=.*?[\d])[a-z\d]{6,}/i

  validates :nickname, presence:true
  validates :family_name, presence:true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/}
  validates :first_name, presence:true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/}
  validates :kana_family_name, presence:true, format: { with: /\A[ァ-ヶ一]+\z/}
  validates :kana_first_name, presence:true, format: { with: /\A[ァ-ヶ一]+\z/}
  validates :birth_date, presence:true
  validates :password, format: { with: PASSWORD_REGEX, message: "Include both letters and numbers"}
end
