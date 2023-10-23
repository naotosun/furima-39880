class BuysController < ApplicationController

  def index 
    @buyaddresses = BuyAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @buyaddresses = BuyAddress.new(buy_params)
    @item = Item.find(params[:item_id])
    if @buyaddresses.valid?
      @buyaddresses.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def buy_params
    params.require(:buy_address).permit(:post_code, :prefecture_id, :municipality, :street_address, :building_name, :tel_number).merge(user_id: current_user.id,item_id: params[:item_id])
  end

end
