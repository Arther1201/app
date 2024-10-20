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

  private

  def set_default_order_quantity
    self.order_quantity ||= 0
  end
end
