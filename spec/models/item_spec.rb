require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品登録' do
    context '商品登録がうまくいく場合' do
      it 'すべての項目が入力されており、商品価格が¥300~9,999,999の範囲であれば登録できること' do
        expect(@item).to be_valid
      end
    end

    context '商品登録に失敗する場合' do
      it '画像を添付していない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空欄' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include ("Name can't be blank")
      end

      it '商品の説明が空欄' do
        @item.text = ""
        @item.valid?
        expect(@item.errors.full_messages).to include ("Text can't be blank")
      end

      it 'カテゴリー未選択' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Category must be other than 1")
      end

      it '商品の状態未選択' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Condition must be other than 1")
      end

      it '配送料の負担未選択' do
        @item.feebearing_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Feebearing must be other than 1")
      end

      it '発送元の地域未選択' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Area must be other than 1")
      end

      it '発送までの日数未選択' do
        @item.preparation_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Preparation must be other than 1")
      end

      it '価格が空欄' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include ("Price can't be blank")
      end

      it '価格の範囲が¥300~9,999,999を逸脱（¥300未満）' do
        @item.price = Faker::Number.between(from: 0, to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include ("Price ：販売価格は¥300〜9,999,999の範囲で、半角数字で入力してください")
      end

      it '価格の範囲が¥300~9,999,999を逸脱（¥9,999,999超）' do
        @item.price = Faker::Number.number(digits: 8)
        @item.valid?
        expect(@item.errors.full_messages).to include ("Price ：販売価格は¥300〜9,999,999の範囲で、半角数字で入力してください")
      end

      it '価格が半角数字でない' do
        @item.price = @item.price.to_s.tr("0-9","０-９")
        @item.valid?
        expect(@item.errors.full_messages).to include ("Price ：販売価格は¥300〜9,999,999の範囲で、半角数字で入力してください")
      end
    end
  end
end
