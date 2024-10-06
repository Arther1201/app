class MetalUsagesController < ApplicationController
  def new
    @metal = Metal.find(params[:metal_id])
    @usage = @metal.metal_usages.new
  end

  def create
    @metal = Metal.find(params[:metal_id])
    @metal_usage = @metal.metal_usages.new(metal_usage_params)
  
    if @metal_usage.save
      @metal.update_remaining_quantity
      render json: {
        success: true,
        remaining_quantity: @metal.remaining_quantity,
        total_usage: @metal.metal_usages.sum(:used_quantity),
        usage: {
          used_date: @metal_usage.used_date,
          department: @metal_usage.department,
          used_quantity: @metal_usage.used_quantity
        }
      }
    else
      render json: { success: false, errors: @metal_usage.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @usage = MetalUsage.find(params[:id])
    @usage.destroy
    respond_to do |format|
      format.html { redirect_to metal_path(@usage.metal), notice: '使用履歴が削除されました。' }
      format.js   # JavaScriptリクエストに対応する
    end
  end

  private

  def metal_usage_params
    params.require(:metal_usage).permit(:used_quantity, :department, :used_date)
  end
end
