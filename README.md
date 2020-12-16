# テーブル設計

## usersテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| nickname           | string     | null: false                    |
| email              | string     | null: false                    |
| password           | string     | null: false                    |
| first_name_kanji   | string     | null: false                    |
| last_name_kanji    | string     | null: false                    |
| first_name_kana    | string     | null: false                    |
| last_name_kana     | string     | null: false                    |
| birth_year         | integer    | null: false                    |
| birth_month        | integer    | null: false                    |
| birth_day          | integer    | null: false                    |

### Association
- has_many :items
- has_many :cards
- has_many :addresses


## itemsテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| image              | -          | ActiveStorage                  |
| name               | string     | null: false                    |
| text               | text       | null: false                    |
| category           | string     | null: false, pull-down list    |
| condition          | string     | null: false, pull-down list    |
| fee_bearing        | string     | null: false, pull-down list    |
| delivery_area      | string     | null: false, pull-down list    |
| preparation_period | string     | null: false, pull-down list    |
| price              | integer    | null: false                    |
| user               | references |                                |

### Association
- belongs_to :user
- has_one :card
- has_one :address


## cardsテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| number             | integer    | null: false                    |
| expiration_month   | integer    | null: false                    |
| expiration_year    | integer    | null: false                    |
| cord               | integer    | null: false                    |
| user               | references |                                |
| item               | references |                                |

### Association
- belongs_to :user
- belongs_to :item


## addressesテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post_number        | integer    | null: false                    |
| prefecture         | string     | null: false                    |
| municipality       | string     | null: false                    |
| address            | string     | null: false                    |
| building           | string     | null: false                    |
| phone              | integer    | null: false                    |
| user               | references |                                |
| item               | references |                                |


### Association
- belongs_to :user
- belongs_to :item