require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー情報' do
    context 'ユーザー登録ができるとき' do
      it '必須項目全てに入力すると登録ができる' do
        expect(@user).to be_valid
      end
      it 'パスワードは、6文字以上での入力があれば、登録ができる' do
        @user.password = 'abc123'
        expect(@user).to be_valid
      end
      it 'パスワードは、半角英数字が混合されていれば、登録ができる' do
        @user.password = 'abc123'
        expect(@user).to be_valid
      end
      it 'パスワードは、確認用を含めて2回入力が必要' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end
      it 'パスワードとパスワード（確認用）は、値が一致していれば登録できる' do
        @user.password = 'abc123'
        @user.password_confirmation = 'xyz000'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
    end

    context 'ユーザー登録ができないとき' do
      it 'ニックネームが空欄では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'メールアドレスが空欄だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Email has already been taken'
      end
      it 'メールアドレスは、@を含む記述でないと登録できない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it 'パスワードが空欄では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'パスワードは、6文字以上での入力がないと登録できない' do
        @user.password = 'xx123'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end
      it '半角英語のみでは登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password Include both letters and numbers'
      end
      it '半角数字のみでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password Include both letters and numbers'
      end
      it '全角では登録できない' do
        @user.password = 'ａｂｃ１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password Include both letters and numbers'
      end
    end
  end

  describe '本人情報の登録' do
    context '本人情報の登録ができないとき' do
      it 'ユーザー本名は、名字の入力が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it 'ユーザー本名は、名前の入力が必須であること' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name can't be blank"
      end
      it 'ユーザー本名の名字は、全角（漢字・ひらがな・カタカナ）での入力でないと登録できない' do
        @user.family_name = 'tanaka'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Family name Full-width characters'
      end
      it 'ユーザー本名の名前は、全角（漢字・ひらがな・カタカナ）での入力でないと登録できない' do
        @user.first_name = 'jiro'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name Full-width characters'
      end
      it 'ユーザー本名のフリガナは、名字の入力が必須であること' do
        @user.kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Kana first name can't be blank"
      end
      it 'ユーザー本名のフリガナは、名前の入力が必須であること' do
        @user.kana_family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Kana family name can't be blank"
      end
      it 'ユーザー本名の名字のフリガナは、全角（カタカナ）での入力がないと登録できない' do
        @user.kana_family_name = 'ﾀﾅｶ'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Kana family name Full-width katakana characters'
      end
      it 'ユーザー本名の名前のフリガナは、全角（カタカナ）での入力がないと登録できない' do
        @user.kana_first_name = 'ｼﾞﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Kana first name Full-width katakana characters'
      end
      it 'ユーザー本名の名字のフリガナは、カタカナ以外の全角文字だと登録できない' do
        @user.kana_family_name = 'たなか'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Kana family name Full-width katakana characters'
      end
      it 'ユーザー本名の名前のフリガナは、カタカナ以外の全角文字だと登録できない' do
        @user.kana_first_name = 'じろう'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Kana first name Full-width katakana characters'
      end
      it '生年月日が空欄では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birth date can't be blank"
      end
    end
  end
end
