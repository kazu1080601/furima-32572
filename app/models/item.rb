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
end
