class Metal < ApplicationRecord
    has_many :metal_transactions, class_name: 'MetalTransaction', foreign_key: 'metal_id'
    has_many :metal_usages
    has_many :metal_purchases, dependent: :destroy
  
    after_initialize :set_default_remaining_quantity, if: :new_record?
  
    def total_quantity
      metal_purchases.sum(:purchase_quantity)
    end
  
    def remaining_quantity
        (total_quantity || 0) - (metal_usages.sum(:used_quantity) || 0)
    end
  
    def update_remaining_quantity
        self.with_lock do
          total_purchased = metal_purchases.sum(:purchase_quantity)
          total_used = metal_usages.sum(:used_quantity)
          self.remaining_quantity = total_purchased - total_used
          save!
        end
    end
  
    private
  
    def set_default_remaining_quantity
      self.remaining_quantity ||= 0
    end
  end
  