# テーブル設計

## users テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| family_name      | string | null: false |
| first_name       | string | null: false |
| kana_family_name | string | null: false |
| kana_first_name  | string | null: false |
| birth_year       | string | null: false |
| birth_month      | string | null: false |
| birth_day        | string | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user             | references | null: false, foreign_key: true |
| image            | string     | null: false                    |
| item_name        | string     | null: false                    |
| item_text        | text       | null: false                    |
| category         | string     | null: false                    |
| status           | string     | null: false                    |
| delivery_fee     | string     | null: false                    |
| area             | string     | null: false                    |
| days             | string     | null: false                    |
| price            | integer    | null: false                    |
| fee              | integer    | null: false                    |
| sales_profit     | integer    | null: false                    |

### Association

- belongs_to :user
- has_one :purchase

## purchase テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |
| card_number      | integer    | null: false                    |
| expiration_month | integer    | null: false                    |
| expiration_year  | integer    | null: false                    |
| postal_cord      | string     | null: false                    |
| prefecture       | string     | null: false                    |
| municipality     | string     | null: false                    |
| address          | string     | null: false                    |
| building_name    | string     | null: false                    |
| phone_number     | string     | null: false                    |

### Association

- belongs_to :user
- belongs_to :item