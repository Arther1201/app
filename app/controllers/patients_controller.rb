class PatientsController < ApplicationController

  before_action :set_patient, only: [:update_note_checked, :update_delivery_checked]
  before_action :check_guest_user, only: [:index]
  before_action :authenticate_user
  
  def index
    guest_user = User.find_by(email: 'guest@example.com') 

    if current_user.guest?
      # ゲストユーザーの場合、自分の患者だけを取得
      @patients = Patient.where(user_id: current_user.id).order(impression_date: :asc).page(params[:page]).per(20)
    else
      # 通常のユーザーの場合、全ての患者データを取得
      @patients = Patient.where.not(user_id: guest_user.id).order(impression_date: :asc).page(params[:page]).per(20)
    end
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

    if params[:patient][:set_status] == 'tel_wait'
      @patient.set_date = nil
    end
  
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
    @patient = current_user.patients.build(patient_params)
    @patient.prosthesis_sites = (params[:patient][:upper_left] || []) +
                              (params[:patient][:upper_right] || []) +
                              (params[:patient][:lower_left] || []) +
                              (params[:patient][:lower_right] || [])

    existing_model = Model.find_by(medical_record_number: @patient.medical_record_number, patient_name: @patient.name)

    if params[:patient][:set_status] == 'tel_wait'
      @patient.set_date = nil
    end

    if existing_model
      flash[:alert] = "登録された模型があります."
    end

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

    if current_user.nil?
      Rails.logger.error "current_userがnilです"
      head :unprocessable_entity
      return
    end

    if @patient.update(note_checked: note_checked_value)
      head :ok  # HTTPステータスコード200を返し、それ以上の処理は行わない
    else
      Rails.logger.error @patient.errors.full_messages.join(", ")
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
    guest_user = User.find_by(email: 'guest@example.com')
  
    if current_user.guest?
      @patients = Patient.where(user_id: current_user.id).order(impression_date: :asc)
    else
      @patients = Patient.where.not(user_id: guest_user.id).order(impression_date: :asc)
    end
  
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
    guest_user = User.find_by(email: 'guest@example.com')
  
    if current_user.guest?
      # ゲストユーザーの場合、自分の患者データのみ取得
      @patients = Patient.where(user_id: current_user.id)
    else
      # 通常のユーザーの場合、ゲストデータを除く全ての患者データを取得
      @patients = Patient.where.not(user_id: guest_user.id)
    end
  
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
  
  def archive
    year = params[:year] || Date.current.year
    patients_to_archive = Patient.where('extract(year from impression_date) = ?', year)
  
    patients_to_archive.each do |patient|
      archive_entry = PatientArchive.new(
        patient_id: patient.id,
        name: patient.name,
        medical_record_number: patient.medical_record_number,
        impression_date: patient.impression_date,
        prosthesis_type_insurance: patient.prosthesis_type_insurance, # 補綴種類の保存
        prosthesis_type_crown: patient.prosthesis_type_crown,
        prosthesis_type_denture: patient.prosthesis_type_denture,
        upper_left: patient.upper_left, # 補綴部位の保存
        upper_right: patient.upper_right,
        lower_left: patient.lower_left,
        lower_right: patient.lower_right,
        metal_amount: patient.metal_amount,
        requester: patient.requester,
        trial_or_set: patient.trial_or_set,
        set_date: patient.set_date,
        note_checked: patient.note_checked,
        delivery_checked: patient.delivery_checked,
        archived_year: year,
        user_id: current_user.id
      )
  
      unless archive_entry.save
        flash[:alert] = "アーカイブに失敗しました: #{archive_entry.errors.full_messages.join(', ')}"
        redirect_to patients_path and return
      end
    end
  
    flash[:notice] = "#{year}年の患者データをアーカイブしました。"
    redirect_to patients_path
  end
  
  # アーカイブの一覧を表示
  def archives
    @archives = PatientArchive.where(user_id: current_user.id).select(:archived_year).distinct.order(archived_year: :desc)
  end
  
  # アーカイブの詳細を表示
  def show_archive
    @archive_patients = PatientArchive.where(archived_year: params[:year], user_id: current_user.id).page(params[:page]).per(20)
  end

  private

  def authenticate_user
    unless current_user
      redirect_to login_path, alert: 'ログインが必要です。'
    end
  end

  def patient_params
    params.require(:patient).permit(:impression_date, :note_checked, :medical_record_number, :name, :gender, :prosthesis_type_insurance, :prosthesis_type_crown, :prosthesis_type_denture, :prosthesis_site, :requester, :metal_type, :metal_amount, :trial_or_set, :set_date, :tel_pending, :delivery_checked, :memo, :medicine_notebook, images: [], remove_images: [], upper_right: [], upper_left: [], lower_right: [], lower_left: [], prosthesis_sites: [])
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def metal_amount_params
    params.require(:patient).permit(:metal_amount)
  end

  def check_guest_user
    if current_user.nil?
      redirect_to login_path, alert: "ログインしてください。"
    elsif current_user.guest?
    end
  end

end
