require 'rails_helper'

RSpec.describe BuyAddress, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @buy_address = FactoryBot.build(:buy_address, user_id: user.id, item_id:item.id)
    end



    context '内容に問題ない場合' do
      
      it "記入項目が正しく記入されていれば保存ができること" do
        expect(@buy_address).to be_valid
      end

      it "建物名は任意であること" do
        @buy_address.building_name = nil
        expect(@buy_address).to be_valid
      end


    end

    context '内容に問題がある場合' do
      
      it "郵便番号が必須であること" do
        @buy_address.post_code = nil
        @buy_address.valid?
        
        expect(@buy_address.errors.full_messages).to include("Post code can't be blank")
      end

      it "郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと" do
        @buy_address.post_code = 1234567
        @buy_address.valid?
        
        expect(@buy_address.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")

      end
      
      
      it "都道府県が必須であること" do
        @buy_address.prefecture_id = 0
        @buy_address.valid?
        
        expect(@buy_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it "市町村が必須であること" do
        @buy_address.municipality = nil
        @buy_address.valid?
        
        expect(@buy_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it "番地が必須であること" do
        @buy_address.street_address = nil
        @buy_address.valid?
        
        expect(@buy_address.errors.full_messages).to include("Street address can't be blank")
      end


      it " 電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと(9桁の場合)" do
        @buy_address.tel_number = 123456789
        @buy_address.valid?
        
        expect(@buy_address.errors.full_messages).to include("Tel number should be 10 to 11 digits of numeric characters")
      end

      it " 電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと(12桁の場合)" do
        @buy_address.tel_number = 123456789012
        @buy_address.valid?
        
        expect(@buy_address.errors.full_messages).to include("Tel number should be 10 to 11 digits of numeric characters")
      end

      it " 電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと(半角数値以外の場合)" do
        @buy_address.tel_number = 123-456-789
        @buy_address.valid?
        
        expect(@buy_address.errors.full_messages).to include("Tel number should be 10 to 11 digits of numeric characters")
      end

      it "user_idが必須であること" do
        @buy_address.user_id = nil
        @buy_address.valid?
        
        expect(@buy_address.errors.full_messages).to include("User can't be blank")
      end

      it "item_idが必須であること" do
        @buy_address.item_id = nil
        @buy_address.valid?
        
        expect(@buy_address.errors.full_messages).to include("Item can't be blank")
      end

      it "tokenが必須であること" do
        @buy_address.token = nil
        @buy_address.valid?
        
        expect(@buy_address.errors.full_messages).to include("Token can't be blank")
      end

    end
  end
end
