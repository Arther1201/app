class Supply < ApplicationRecord
  has_many :orders, dependent: :destroy
  belongs_to :department
  before_save :set_default_order_quantity
    # 年間の注文数を取得
  def self.total_orders(year)
    where('extract(year from order_date) = ?', year).sum(:order_quantity)
  end

  # 年間の消費数を計算（例として納品日がある物品を消費済みとします）
  def self.total_consumed(year)
    where('extract(year from delivery_date) = ?', year).sum(:order_quantity)
  end

  def calculate_consumption
    self.consumption = (last_year_stock || 0) + (supplies_all_quantity || 0) - (current_year_stock || 0)
    save
  end

  def set_current_stock_as_last_year
    self.last_year_stock = self.current_year_stock
    save
  end

  def reset_current_year_stock
    self.current_year_stock = 0
    save
  end

  def supplies_all_quantity
    order_quantity || 0
  end

  private

  def set_default_order_quantity
    self.order_quantity ||= 0
  end
end
