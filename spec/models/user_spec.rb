require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '全ての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'ab123'
        @user.password_confirmation = 'ab123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが半角英数字混合でなければ登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Input half-width characters.')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'abcd1234'
        @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'familynameが空では登録できない' do
        @user.familyname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Familyname can't be blank")
      end
      it 'firstnameが空では登録できない' do
        @user.firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname can't be blank")
      end
      it 'familynameが全角でなければ登録できない' do
        @user.familyname = 'ﾅﾏｴ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Familyname is invalid. Input full-width characters.')
      end
      it 'firstnameが全角でなければ登録できない' do
        @user.firstname = 'ﾅﾏｴ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Firstname is invalid. Input full-width characters.')
      end
      it 'familyname_kanaが空では登録できない' do
        @user.familyname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Familyname kana can't be blank")
      end
      it 'firstname_kanaが空では登録できない' do
        @user.firstname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname kana can't be blank")
      end
      it 'familyname_kanaが全角カタカナでなければ登録できない' do
        @user.familyname_kana = 'なまえ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Familyname kana is invalid. Input full-width katakana characters.')
      end
      it 'firstname_kanaが全角カタカナでなければ登録できない' do
        @user.firstname_kana = 'なまえ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Firstname kana is invalid. Input full-width katakana characters.')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
