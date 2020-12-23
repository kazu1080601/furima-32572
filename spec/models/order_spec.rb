require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  describe '商品購入' do
    context '商品購入がうまくいく場合' do
      it 'すべての項目が入力されていれば登録できる' do
        expect(@order).to be_valid
      end

      it '建物が空欄でも登録できる' do
        @order.building = ''
        expect(@order).to be_valid
      end
    end

    context '商品購入がうまくいかない場合' do
      it 'カード決済のトークンが空' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が空欄' do
        @order.post_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Post number can't be blank")
      end

      it '郵便番号にハイフンが含まれない' do
        @order.post_number = Faker::Number.number(digits: 7)
        @order.valid?
        expect(@order.errors.full_messages).to include('Post number is invalid. Include hyphen(-)')
      end

      it '都道府県が選択されていない' do
        @order.area_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include('Area select')
      end

      it '市区町村が空欄' do
        @order.municipality = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Municipality can't be blank")
      end

      it '番地が空欄' do
        @order.address = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空欄' do
        @order.phone = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone can't be blank")
      end

      it '電話番号はハイフンが不要で11桁以内' do
        @order.phone = Faker::Number.leading_zero_number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s + '-' + Faker::Number.number(digits: 4).to_s
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone is invalid. Input half-width characters without hyphen(-).')
      end

      it '電話番号が12桁以上' do
        @order.phone = Faker::Number.leading_zero_number(digits: 12)
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone is invalid. Input half-width characters without hyphen(-).')
      end
    end
  end
end
