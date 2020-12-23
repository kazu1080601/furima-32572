class Order
  include ActiveModel::Model
  attr_accessor :token, :post_number, :area_id, :municipality, :address, :building, :phone, :user_id, :item_id

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(post_number: post_number, municipality: municipality, address: address, building: building, phone: phone, purchase_id: purchase.id, area_id: area_id)
  end
end