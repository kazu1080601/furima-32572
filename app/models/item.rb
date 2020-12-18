class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :feebearing
  belongs_to :area
  belongs_to :preparation

  validates :image, :name, :text, presence: true
  validates :category_id, :condition_id, :feebearing_id, :area_id, :preparation_id, numericality: { other_than: 1 }
  validates :price, presence: true
  validate  :price_check

  def price_check
    return if price == nil || (price >= 300 && price <= 9999999)

    errors.add :price, '販売価格は¥300〜9,999,999の範囲で入力してください'
  end

end
