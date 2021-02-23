require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品ができるとき' do
      it '必須項目全てに入力すると登録ができる' do
        expect(@item).to be_valid
      end
      it '販売価格が300円以上なら出品できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it '販売価格が9,999,999円以下なら出品できる' do
        @item.price = 9999999
        expect(@item).to be_valid
      end
      it '販売価格が半角数字なら出品できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
    end

    context '商品出品できないとき' do
      it '商品画像をつけないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it '商品名の入力がないと出品できない' do
        @item.item_name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include "Item name can't be blank"
      end
      it '商品の説明の入力がないと出品できない' do
        @item.item_text = ""
        @item.valid?
        expect(@item.errors.full_messages).to include "Item text can't be blank"
      end
      it 'カテゴリーの情報が必須であること' do
        @item.category_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
      it '商品の状態についての情報が必須であること' do
        @item.status_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include "Status can't be blank"
      end
      it '配送料の負担についての情報が必須であること' do
        @item.deliveryfee_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include "Deliveryfee can't be blank"
      end
      it '発送元の地域についての情報が必須であること' do
        @item.area_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include "Area can't be blank"
      end
      it '発送までの日数についての情報が必須であること' do
        @item.days_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include "Days can't be blank"
      end
      it '販売価格についての情報が必須であること' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      it '販売価格は、¥300以下では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be greater than or equal to 300"
      end
      it '販売価格は、¥9,999,999以上では出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be less than or equal to 9999999"
      end
      it '販売価格は半角数字のみ保存可能であること' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not a number"
      end
    end
  end
end
