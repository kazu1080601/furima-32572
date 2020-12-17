# テーブル設計

## usersテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| nickname           | string     | null: false                    |
| email              | string     | null: false                    |
| encrypted_password | string     | null: false                    |
| first_name_kanji   | string     | null: false                    |
| last_name_kanji    | string     | null: false                    |
| first_name_kana    | string     | null: false                    |
| last_name_kana     | string     | null: false                    |
| birthday           | date       | null: false                    |

### Association
- has_many :items
- has_many :purchases


## itemsテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| text               | text       | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| feebearing_id      | integer    | null: false                    |
| area_id            | integer    | null: false                    |
| preparation_id     | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | foreign_key: true              |

### Association
- belongs_to :user
- has_one :purchase
- belongs_to :category
- belongs_to :condition
- belongs_to :feebearing
- belongs_to :area
- belongs_to :preparation


## purchasesテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | foreign_key: true              |
| item               | references | foreign_key: true              |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address


## addressesテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post_number        | string     | null: false                    |
| prefecture         | string     | null: false                    |
| municipality       | string     | null: false                    |
| address            | string     | null: false                    |
| building           | string     |                                |
| phone              | string     | null: false                    |
| purchase           | references | foreign_key: true              |

### Association
- belongs_to :purchase
