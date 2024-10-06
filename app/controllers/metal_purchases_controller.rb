class MetalPurchasesController < ApplicationController
  before_action :set_metal
  before_action :set_purchase, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @purchase.update(purchase_params)
      redirect_to metal_path(@metal), notice: '購入情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @purchase.destroy
    redirect_to metal_path(@metal), notice: '購入情報が削除されました。'
  end

  private

  def set_metal
    @metal = Metal.find(params[:metal_id])
  end

  def set_purchase
    @purchase = @metal.metal_purchases.find(params[:id])
  end

  def purchase_params
    params.require(:metal_purchase).permit(:purchase_date, :purchase_quantity, :price, :supplier)
  end
end
