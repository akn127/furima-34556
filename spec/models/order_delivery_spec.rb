require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  describe '購入情報の入力' do
    before do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      @order_delivery = FactoryBot.build(:order_delivery, item_id: item.id, user_id: user.id)
      sleep 0.1
    end

    it '配送先の必須事項を全て入力すると購入情報が保存できる' do
      expect(@order_delivery).to be_valid
    end
    it '建物名の情報は空でも保存ができる' do
      @order_delivery.building_name = ""
      expect(@order_delivery).to be_valid
    end
   
    it '郵便番号が空では保存ができない' do
      @order_delivery.postal_code = ""
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("Postal code can't be blank")
    end
    it'郵便番号にハイフンなしでは保存ができない' do
      @order_delivery.postal_code = "1234567"
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end
    it '都道府県の情報は1以外を選択しなければ保存できない' do
      @order_delivery.area_id = 1
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("Area can't be blank")
    end
    it '市区町村の情報が空では保存できない' do
      @order_delivery.municipality = ""
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("Municipality can't be blank")
    end
    it '番地の情報が空では保存できない' do
      @order_delivery.address = ""
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("Address can't be blank")
    end
    it '電話番号の情報が空では保存できない' do
      @order_delivery.phone_number = ""
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("Phone number can't be blank")
    end
    it '電話番号は11桁以内の数字でなければ保存できない' do
      @order_delivery.phone_number = "111112222233"
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
    end
    it '電話番号に英字は保存できない' do
      @order_delivery.phone_number = "number12345"
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("Phone number is not a number")
    end
    it '電話番号にハイフンは保存できない' do
      @order_delivery.phone_number = "01-123-4567"
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("Phone number is not a number")
    end
    it 'tokenが空では登録ができないこと' do
      @order_delivery.token = nil
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("Token can't be blank")
    end
    it 'item_idがないと登録できないこと' do
      @order_delivery.item_id = nil
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("Item can't be blank")
    end
    it 'user_idがないと登録できないこと' do
      @order_delivery.user_id = nil
      @order_delivery.valid?
      expect(@order_delivery.errors.full_messages).to include("User can't be blank")
    end
  end
end