class OrdersController < ApplicationController
    def mark_delivered
        @order = Order.find(params[:id])
    
        # deliveredがtrueのときのみ納品日を今日の日付に設定
        if params[:delivered].to_s == "true"
          @order.update(delivery_date: Date.today)
        else
          @order.update(delivery_date: nil)
        end
    
        if @order.save
          render json: { status: 'success' }
        else
          render json: { status: 'error', message: @order.errors.full_messages.join(", ") }, status: :unprocessable_entity
        end
    end
end
