# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

|Column             |Type   |Options                   |
|-------------------|-------|--------------------------|
|nickname           |string |null: false               |
|email              |string |null: false, unique: true |
|encrypted_password |string |null: false               |
|familyname         |string |null: false               |
|firstname          |string |null: false               |
|familyname_kana    |string |null: false               |
|firstname_kana     |string |null: false               |
|birthday           |date   |null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

|Column           |Type       |Options                        |
|-----------------|-----------|-------------------------------|
|itemname         |string     |null: false                    |
|explanation      |text       |null: false                    |
|category_id      |integer    |null: false                    |
|status_id        |integer    |null: false                    |
|shipping_cost_id |integer    |null: false                    |
|prefecture_id    |integer    |null: false                    |
|shipping_date_id |integer    |null: false                    |
|price            |integer    |null: false                    |
|user             |references |null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order
- has_one_attached :image

- belongs_to :category
- belongs_to :status
- belongs_to :shipping_cost
- belongs_to :prefecture
- belongs_to :shipping_date

## orders テーブル

| Column | Type      | Options                       |
| ------ | ----------|------------------------------ |
|user    |references |null: false, foreign_key: true |
|item    |references |null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :destination

## destinations テーブル

|Column        |Type       |Options                        |
|--------------|-----------|-------------------------------|
|post_code     |string     |null: false                    |
|prefecture_id |integer    |null: false                    |
|city          |string     |null: false                    |
|address       |string     |null: false                    |
|building      |string     |                               |
|phone_number  |string     |null: false                    |
|order         |references |null: false, foreign_key: true |

### Association

- belongs_to :order

- belongs_to :prefecture
