class BuyAddress
  include ActiveModel::Model
  attr_accessor :user_id,:item_id,:post_code, :prefecture_id, :municipality, :street_address, :building_name, :tel_number

  with_options presence: true do

    validates :user_id
    validates :item_id
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id
    validates :municipality
    validates :street_address
    validates :tel_number, format: { with: /\A\d{10,11}\z/, message: "should be 10 to 11 digits of numeric characters" }
  end
  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}

  def save

    buy = Buy.create(user_id: user_id, item_id: item_id)

    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, street_address: street_address, building_name: building_name, tel_number: tel_number, buy_id: buy.id)


  end
end

## @shipping_date = ShippingDate.new