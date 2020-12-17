require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "新規登録がうまくいく場合" do
      it "すべての項目が入力されていれば登録できること" do
        expect(@user).to be_valid
      end
    end

    context "新規登録がうまくいかない場合" do
      it "ニックネームが空欄" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "メールアドレスが空欄" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "メールアドレスが登録済" do
        user = FactoryBot.create(:user)
        @user.email = user.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end

      it "メールアドレスに「@」が含まれない" do
        @user.email = Faker::Lorem.characters(number: 10)
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "パスワードが空欄" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "パスワードが6文字未満" do
        @user.password = Faker::Internet.password(min_length: 3, max_length: 3) + "1" + "a"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "パスワードが半角英数字混合でない（半角英字のみ）" do
        @user.password = Faker::Name.initials(number: 10)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Complexity requirement not met. Length should be 6 characters minimum and include at least one letter and one number.")
      end

      it "パスワードが半角英数字混合でない（半角数字のみ）" do
        @user.password = Faker::Number.number(digits: 10)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Complexity requirement not met. Length should be 6 characters minimum and include at least one letter and one number.")
      end

      it "パスワード確認欄が空欄" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "パスワード確認が不一致" do
        @user.password_confirmation = Faker::Internet.password(min_length: 6)
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "ユーザー本名の名前（漢字）が空欄" do
        @user.first_name_kanji = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanji can't be blank")
      end

      it "ユーザー本名の名前（漢字）が全角（漢字・ひらがな・カタカナ）でない" do
        @user.first_name_kanji = Faker::Name.initials(number: 2)
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（全角）の名前には、全角文字を記入してください")
      end

      it "ユーザー本名の名字（漢字）が空欄" do
        @user.last_name_kanji = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kanji can't be blank")
      end

      it "ユーザー本名の名字（漢字）が全角（漢字・ひらがな・カタカナ）でない" do
        @user.last_name_kanji = Faker::Name.initials(number: 2)
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（全角）の名字には、全角文字を記入してください")
      end

      it "ユーザー本名の名前（カナ）が空欄" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it "ユーザー本名の名前（カナ）が全角（カタカナ）でない" do
        @user.first_name_kana = Gimei.name.first.kanji
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（カナ）の名前には、全角カナを記入してください")
      end

      it "ユーザー本名の名字（カナ）が空欄" do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it "ユーザー本名の名字（カナ）が全角（カタカナ）でない" do
        @user.last_name_kana = Gimei.name.last.kanji
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（カナ）の名字には、全角カナを記入してください")
      end

      it "生年月日が空欄" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
