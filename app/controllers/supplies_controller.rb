class SuppliesController < ApplicationController
  def index
    @supplies = Supply.where(department_id: current_user.department_id).page(params[:page]).per(20)

    # 分類の一覧を取得してビューに渡す
    @categories = Supply.where(department_id: current_user.department_id).distinct.pluck(:category)

    if params[:category].present?
      @supplies = @supplies.where('category LIKE ?', "%#{params[:category]}%")
    end

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
    @supply.stock_quantity = (@supply.stock_quantity || 0) + additional_quantity
    @supply.order_date = Date.today
  
    # 注文履歴に新しい注文を追加
    order = @supply.orders.build(order_date: Date.today, order_quantity: additional_quantity)
  
    if @supply.save && order.save
      flash[:notice] = "注文が更新されました。"
      redirect_to supplies_path
    else
      flash[:alert] = "注文の更新に失敗しました。"
      render :edit
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
    if @supply.update(supply_params)
      redirect_to supplies_path(@supply), notice: '物品情報が更新されました。'
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

    archived_data = supplies.as_json # データをJSON形式に変換
    SupplyArchive.create(year: year, archived_data: archived_data.to_json)

    redirect_to supplies_path, notice: "#{year}年のデータをアーカイブしました。"
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
    params.require(:supply).permit(:item_name, :category, :order_date, :order_quantity, :delivery_date, :stock_quantity, :manufacturer, :price)
  end
end
