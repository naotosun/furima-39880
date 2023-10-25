FactoryBot.define do
  factory :buy_address do
    post_code { '123-4567' }
    prefecture_id { 9 }
    municipality { '宇都宮市' }
    street_address { '1-1' }
    building_name { 'Tハイツ' }
    tel_number { '07022223333' }
    
    token {"tok_abcdefghijk00000000000000000"}
  end
end
