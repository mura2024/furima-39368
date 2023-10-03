class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  with_options presence: true do
    validates :nickname
    validates :familyname
    validates :firstname
    validates :familyname_kana
    validates :firstname_kana
    validates :birthday
  end

  with_options allow_blank: true do
    validates :familyname, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は無効です。全角文字を入力してください。' }
    validates :firstname, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は無効です。全角文字を入力してください。' }
    validates :familyname_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'は無効です。全角カタカナを入力してください。' }
    validates :firstname_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'は無効です。全角カタカナを入力してください。' }
    validates :password,
              format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は無効です。半角文字を入力してください。' }
  end
end
