class BuysController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]#
  before_action :select_item, only: [:index,:create]#
  before_action :redirect_to_create, only: [:index, :create]#
  before_action :redirect_to_create2, only: [:index, :create]#
  before_action :set_public_key, only: [:index, :create]

  def index 
    @buyaddresses = BuyAddress.new
    
  end

  def create
    @buyaddresses = BuyAddress.new(buy_params)
    
    if @buyaddresses.valid?
      pay_item
      @buyaddresses.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private
  def buy_params
    params.require(:buy_address).permit(:post_code, :prefecture_id, :municipality, :street_address, :building_name, :tel_number).merge(user_id: current_user.id,item_id: params[:item_id],token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: buy_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end


  def redirect_to_create#
    return redirect_to root_path if @item.buy != nil
  end

  def select_item#
    @item = Item.find(params[:item_id])
  end

  def redirect_to_create2#
    return redirect_to root_path if current_user.id == @item.user.id
  end

  def set_public_key
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end
end
