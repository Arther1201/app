class MetalPurchase < ApplicationRecord
  belongs_to :metal

  private

  def update_metal_quantity
    metal.update_remaining_quantity
  end
end

