class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :feebearing
  belongs_to :area
  belongs_to :preparation
end
