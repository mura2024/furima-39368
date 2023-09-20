class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:index, :create]
  before_action :correct_user, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :house_number, :building,
       :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

  def set_order
    @item = Item.find(params[:item_id])
  end

  def correct_user
    if @item.user_id == current_user.id || @item.order.present?
      redirect_to root_path
    end
  end

end
