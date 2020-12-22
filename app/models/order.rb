class Order
  include ActveModel::Model
  attr_accessor :token, :post_number, :prefecture, :municipality, :address, :building, :phone

  def save
    Address.create(post_number: post_number, prefecture: prefecture, municipality: municipality, address: address, building: building, phone: phone)
  end
end