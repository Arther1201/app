class ModelsController < ApplicationController
    def index
        @models = Model.all
      
        if params[:search].present?
          @models = @models.where('patient_name LIKE ? OR medical_record_number LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
        end
      
        if params[:impression_date].present?
          @models = @models.where(impression_date: params[:impression_date])
        end
      
        @models = @models.order(created_at: :desc).page(params[:page])
    end
    
    # 保管場所の更新
    def update_storage_location
      @model = Model.find(params[:id])
      if @model.update(model_params)
        flash[:success] = "保管場所が更新されました。"
      else
        flash[:error] = "保管場所の更新に失敗しました。"
        redirect_to models_path
      end
    end
    
    # モデルの削除
    def destroy
      @model = Model.find(params[:id])
      @model.destroy
      flash[:success] = "模型が削除されました。"
      redirect_to models_path
    end

    def new
      @model = Model.new
    end

    def create
      @model = Model.new(model_params)
      if @model.save
        redirect_to models_path, notice: '患者模型が作成されました。'
      else
        flash[:alert] = "登録に失敗しました"
        render :new
      end
    end
    
    private
    
    def model_params
      params.require(:model).permit(:impression_date, :medical_record_number, :patient_name, :storage_location)
    end
end
