class PatientsController < ApplicationController

  before_action :set_patient, only: [:update_note_checked, :update_delivery_checked]
  
  def index
    @patients = Patient.order(impression_date: :asc).page(params[:page]).per(20)
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def new
    @patient = Patient.new
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
  
    # 画像の削除処理
    if params[:patient][:remove_images].present?
      image_names_to_remove = params[:patient][:remove_images]
      remaining_images = @patient.images.reject { |image| image_names_to_remove.include?(image.identifier) }
    else
      remaining_images = @patient.images.dup
    end
  
    # 新しい画像の追加処理
    if params[:patient][:images].present?
      new_images = params[:patient][:images]
      remaining_images += new_images
    end
  
    if @patient.update(patient_params.except(:remove_images).merge(images: remaining_images))
      redirect_to patient_path(@patient), notice: '患者情報が更新されました。'
    else
      render :edit
    end
  end
  
  
  def create
    puts params.inspect
    @patient = Patient.new(patient_params)
    @patient.prosthesis_sites = (params[:patient][:upper_left] || []) +
                              (params[:patient][:upper_right] || []) +
                              (params[:patient][:lower_left] || []) +
                              (params[:patient][:lower_right] || [])
    if @patient.save
      redirect_to patients_path, notice: '患者が正常に登録されました。'
    else
      render :new
    end
  end

  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    redirect_to patients_path, alert: '患者データが削除されました。'
  end

  def update_note_checked
    @patient = Patient.find(params[:id])
    note_checked_value = params[:note_checked] || params.dig(:patient, :note_checked)
    if @patient.update(note_checked: note_checked_value)
      head :ok  # HTTPステータスコード200を返し、それ以上の処理は行わない
    else
      head :unprocessable_entity  # エラーがある場合は422エラーを返す
    end
  end
  
  def update_delivery_checked
    @patient = Patient.find(params[:id])
    delivery_checked_value = params[:delivery_checked] || params.dig(:patient, :delivery_checked)
    if @patient.update(delivery_checked: delivery_checked_value)
      head :ok  # 同様にHTTPステータスコード200を返す
    else
      head :unprocessable_entity
    end
  end

  def update_metal_amount
    @patient = Patient.find(params[:id])
    if @patient.update(metal_amount_params)
      head :ok
    else
      render json: @patient.errors, status: :unprocessable_entity  # 失敗時はエラーを返す
    end
  end
  
  def search_form
  end

  def search
    @patients = Patient.order(impression_date: :asc).page(params[:page]).per(20)

    if params[:name].present?
      @patients = @patients.where('name LIKE ?', "%#{params[:name]}%")
    end

    if params[:medical_record_number].present?
      @patients = @patients.where('medical_record_number LIKE ?', "%#{params[:medical_record_number]}%")
    end

    if params[:impression_date].present?
      @patients = @patients.where(impression_date: params[:impression_date])
    end

    if params[:set_date].present?
      @patients = @patients.where(set_date: params[:set_date])
    end   

    @patients = @patients.page(params[:page]).per(10)
    
    render 'search_results'
  end

  def calendar
    @patients = Patient.all

    respond_to do |format|
      format.html
      format.json do
        render json: @patients.map { |patient|
          {
            id: patient.id,
            title: patient.name,
            start: patient.set_date,
            end: patient.set_date, # 終了日もセット日と同じ場合
            url: patient_url(patient, format: :html)
          }
        }
      end
    end
  end
  

  private

  def patient_params
    params.require(:patient).permit(:impression_date, :note_checked, :medical_record_number, :name, :gender, :prosthesis_type_insurance, :prosthesis_type_crown, :prosthesis_type_denture, :prosthesis_site, :requester, :metal_type, :metal_amount, :trial_or_set, :set_date, :delivery_checked, :memo, :medicine_notebook, images: [], remove_images: [], upper_right: [], upper_left: [], lower_right: [], lower_left: [], prosthesis_sites: [])
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def metal_amount_params
    params.require(:patient).permit(:metal_amount)
  end

end
