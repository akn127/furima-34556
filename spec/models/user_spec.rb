require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー情報' do
    it 'ニックネームが必須であること' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it 'メールアドレスが必須であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it 'メールアドレスが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include "Email has already been taken"
    end
    it 'メールアドレスは、@を含む必要があること' do
      @user.email = "test.com"
      @user.valid?
      expect(@user.errors.full_messages).to include "Email is invalid"
    end
    it 'パスワードが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it 'パスワードは、6文字以上での入力が必須であること（6文字が入力されていれば、登録が可能なこと）' do
      @user.password = 'abc123'
      expect(@user).to be_valid
    end
    it 'パスワードは、半角英数字混合での入力が必須であること（半角英数字が混合されていれば、登録が可能なこと）' do
      @user.password = 'abc123'
      expect(@user).to be_valid
    end
    it 'パスワードは、確認用を含めて2回入力すること' do
      @user.password = 'abc123'
      @user.password_confirmation = 'abc123'
      expect(@user).to be_valid
    end
    it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
      @user.password = 'abc123'
      @user.password_confirmation = 'xyz000'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
  end

  describe '本人情報確認' do
    it 'ユーザー本名は、名字と名前がそれぞれ必須であること' do
      @user.family_name = "田中"
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end
    it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.family_name = "tanaka"
      @user.first_name = "二郎"
      @user.valid?
      expect(@user.errors.full_messages).to include "Family name Full-width characters"
    end
    it 'ユーザー本名のフリガナは、名字と名前がそれぞれ必須であること' do
      @user.kana_family_name = "タナカ"
      @user.kana_first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Kana first name can't be blank"
    end
    it 'ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.kana_family_name = "ﾀﾅｶ"
      @user.kana_first_name = "ジロウ"
      @user.valid?
      expect(@user.errors.full_messages).to include "Kana family name Full-width katakana characters"
    end
    it '生年月日が必須であること' do
      @user.birth_date = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Birth date can't be blank"
    end
  end
end
