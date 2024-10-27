class SuppliesController < ApplicationController
  def index
    session[:from] = params[:from] if params[:from].present?
    @supplies = Supply.where(department_id: current_user.department_id).page(params[:page]).per(50)

    # 分類の一覧を取得してビューに渡す
    @categories = Supply.where(department_id: current_user.department_id).distinct.pluck(:category)

    if params[:category].present?
      @supplies = @supplies.where('category LIKE ?', "%#{params[:category]}%")
    end
    if params[:item_name].present?
      @supplies = @supplies.where('name LIKE ?', "%#{params[:item_name]}%")
    end
    if params[:order_date].present?
      @supplies = @supplies.where(order_date: params[:order_date])
    end
    if params[:order_quantity].present?
      @supplies = @supplies.where(quantity: params[:order_quantity])
    end
    if params[:delivery_date].present?
      @supplies = @supplies.where(delivery_date: params[:delivery_date])
    end

    @year = params[:year] || Date.current.year
    @total_orders = Supply.total_orders(@year)
    @total_consumed = Supply.total_consumed(@year)

    @supplies = @supplies.order(:category, :item_name)
  end

  def new
    @supply = Supply.new
    @categories = Supply.where(department_id: current_user.department_id).distinct.pluck(:category)
  end

  def create
    category = params[:supply][:new_category].present? ? params[:supply][:new_category] : params[:supply][:category]

    @supply = Supply.new(supply_params)
    @supply.category = category
    @supply.department_id = current_user.department_id

    if params[:supply][:new_category].present?
      @supply.category = params[:supply][:new_category]
    end

    if @supply.save
      redirect_to supplies_path, notice: '物品情報を登録しました。'
    else
      render :new
    end
  end

  def update_quantity
    @supply = Supply.find(params[:id])
    additional_quantity = params[:supply][:order_quantity].to_i
  
    # 在庫数を更新
    @supply.supplies_all_quantity = (@supply.supplies_all_quantity || 0) + additional_quantity
    @supply.order_quantity = (@supply.order_quantity || 0) + additional_quantity
    @supply.order_date = Date.today
  
    # 注文履歴に新しい注文を追加
    order = @supply.orders.build(order_date: Date.today, order_quantity: additional_quantity)
  
    if @supply.save && order.save
      render json: {
        status: 'success',
        message: '注文が更新されました。',
        supply_id: @supply.id,
        supplies_all_quantity: @supply.supplies_all_quantity
      }
    else
      render json: {
        status: 'error',
        message: '注文の更新に失敗しました。'
      }, status: :unprocessable_entity
    end
  end

  def update_inventory
    @supply = Supply.find(params[:id])
    if update_supply(@supply, supply_params)
      @supply.calculate_consumption
      redirect_to supplies_path, notice: '在庫が更新されました'
    else
      render :edit
    end
  end

  def set_last_year_stock
    Supply.all.each do |supply|
      supply.set_current_stock_as_last_year # 各物品で今年の在庫を昨年の在庫に保存
      supply.reset_current_year_stock
    end

    respond_to do |format|
      format.html { redirect_to supplies_path(inventory: true), notice: '今年の在庫数が昨年の在庫数として保存されました。' }
      format.json { head :no_content }
    end
  end

  def bulk_update
    if params[:supplies].present?
      params[:supplies].each do |id, supply_params|
        supply = Supply.find(id)
  
        # 注文総数を累積
        new_order_quantity = supply_params[:order_quantity].to_i
        supply.supplies_all_quantity = (supply.supplies_all_quantity || 0) + new_order_quantity
  
        # 他のフィールドも更新
        supply.update(
          last_year_stock: supply_params[:last_year_stock],
          current_year_stock: supply_params[:current_year_stock],
          consumption: supply_params[:consumption]
        )
      end
  
      flash[:notice] = "注文が更新されました。"
      render json: { status: 'success', message: flash[:notice] }, status: :ok
    else
      flash[:alert] = "更新するデータがありません。"
      render json: { status: 'error', message: flash[:alert] }, status: :unprocessable_entity
    end
  end  


  def show
    @supply = Supply.find(params[:id])
    @orders = @supply.orders.order(created_at: :desc)
  end

  def edit
    @supply = Supply.find(params[:id])
  end

  def update
    @supply = Supply.find(params[:id])
    if update_supply(@supply, supply_params)
      redirect_to supplies_path, notice: '物品情報が更新されました。'
    else
      render :show
    end
  end

  def destroy
    @supply = Supply.find(params[:id])
    if @supply.destroy
      redirect_to supplies_path, noticce: '物品情報を削除しました。'
    else
      redirect_to supplies_path, alert: '物品情報の削除に失敗しました。'
    end
  end

  def archive
    year = params[:year] || Date.current.year
    supplies = Supply.where(order_date: "#{year}-01-01".."#{year}-12-31")
  
    ActiveRecord::Base.transaction do

      archive_data = supplies.map do |supply|
        total_order_quantity = supply.orders.sum(:order_quantity)
        
        {
          id: supply.id,
          category: supply.category,
          item_name: supply.item_name,
          order_quantity: supply.order_quantity,  # 注文総数を保存
          order_date: supply.order_date,
          delivery_date: supply.delivery_date,
          manufacturer: supply.manufacturer,
          price: supply.price,
          total_order_quantity: total_order_quantity,
          consumption: supply.consumption
        }
      end

      # アーカイブを作成
      SupplyArchive.create!(year: year, archived_data: archive_data.to_json)
  
      # 在庫をリセットし、注文履歴を削除
      supplies.each do |supply|
        supply.update(
          order_quantity: 0,          # 注文数のリセット
          current_year_stock: 0,      # 今年の在庫をリセット
          consumption: 0,
          supplies_all_quantity: 0    # 総注文数のリセット
        )
        supply.orders.delete_all
      end
    end
  
    redirect_to supplies_path, notice: "#{year}年のデータをアーカイブしました。"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to supplies_path, alert: "アーカイブに失敗しました。"
  end
  

  def show_archive
    @archive = SupplyArchive.find(params[:id])
    supplies_array = JSON.parse(@archive.archived_data)
    @supplies = Kaminari.paginate_array(supplies_array).page(params[:page]).per(20)
  end

  def archives
    @archives = SupplyArchive.all.order(year: :desc)
  end

  private
  
  def supply_params
    params.require(:supply).permit(:item_name, :category, :order_date, :order_quantity, :delivery_date, :stock_quantity, :manufacturer, :price, :last_year_stock, :current_year_stock, :consumption)
  end

  def update_supply(supply, params)
    supply.update(params)
  end
end
