class MetalsController < ApplicationController
  def index
    @metals = Metal.all
  end

  def new
    @metal = Metal.new
  end

  def create
    @metal = Metal.new(metal_params)
    if @metal.save
      redirect_to metals_path, notice: 'メタルが登録されました'
    else
      render :new
    end
  end

  def edit
    @metal = Metal.find(params[:id])
  end

  def update
    @metal = Metal.find(params[:id])
    if @metal.update(metal_params)
      redirect_to metal_path(@metal), notice: 'メタル情報が更新されました'
    else
      render :edit
    end
  end

  def show
    @metal = Metal.find(params[:id])
    @purchases = @metal.metal_purchases.order(:purchase_date)
    @usages = @metal.metal_usages.order(:used_date)
  end

  def new_purchase
    @metal = Metal.find(params[:id])
    @purchase = MetalPurchase.new
  end

  def create_purchase
    @metal = Metal.find(params[:id])
    @purchase = @metal.metal_purchases.build(purchase_params)

    if @purchase.save
      # 残量に購入量を追加
      @metal.remaining_quantity ||= 0
      @metal.remaining_quantity += @purchase.purchase_quantity
      @metal.save

      redirect_to metal_path(@metal), notice: 'メタルの購入が追加されました。'
    else
      render :new
    end
  end

  private

  def metal_params
    params.require(:metal).permit(:name, :purchase_date, :purchase_quantity, :price, :supplier)
  end

  def purchase_params
    params.require(:metal_purchase).permit(:purchase_date, :purchase_quantity, :price, :supplier)
  end
end
