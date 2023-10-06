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
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'ab123'
        @user.password_confirmation = 'ab123'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは無効です。半角文字を入力してください。')
      end
      it 'passwordが英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは無効です。半角文字を入力してください。')
      end
      it 'passwordが全角英数字では登録できない' do
        @user.password = 'ａｂｃ１２３'
        @user.password_confirmation = 'ａｂｃ１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは無効です。半角文字を入力してください。')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'abcd1234'
        @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      it 'familynameが空では登録できない' do
        @user.familyname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字を入力してください')
      end
      it 'firstnameが空では登録できない' do
        @user.firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名前を入力してください')
      end
      it 'familynameが全角でなければ登録できない' do
        @user.familyname = 'ﾅﾏｴ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字は無効です。全角文字を入力してください。')
      end
      it 'firstnameが全角でなければ登録できない' do
        @user.firstname = 'ﾅﾏｴ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は無効です。全角文字を入力してください。')
      end
      it 'familyname_kanaが空では登録できない' do
        @user.familyname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)を入力してください')
      end
      it 'firstname_kanaが空では登録できない' do
        @user.firstname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名前(カナ)を入力してください')
      end
      it 'familyname_kanaが全角カタカナでなければ登録できない' do
        @user.familyname_kana = 'なまえ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)は無効です。全角カタカナを入力してください。')
      end
      it 'firstname_kanaが全角カタカナでなければ登録できない' do
        @user.firstname_kana = 'なまえ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前(カナ)は無効です。全角カタカナを入力してください。')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
    end
  end
end
