class Order
  include ActiveModel::Model
  attr_accessor :token, :post_number, :area_id, :municipality, :address, :building, :phone

  def save
    Address.create(post_number: post_number, area_id: area_id, municipality: municipality, address: address, building: building, phone: phone)
  end
end