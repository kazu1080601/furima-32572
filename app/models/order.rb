class Order
  include ActiveModel::Model
  attr_accessor :number, :exp_month, :exp_year, :cvc, :token, :post_number, :area_id, :municipality, :address, :building, :phone, :user_id, :item_id

  with_options presence: true do
    validates :post_number, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :municipality, :address
    validates :phone, format: { with: /\A0\d{9,10}\z/, message: "is invalid. Input half-width characters without hyphen(-)."}
  end
  validates :area_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(post_number: post_number, municipality: municipality, address: address, building: building, phone: phone, purchase_id: purchase.id, area_id: area_id)
  end
end