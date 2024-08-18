class PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def new
    @patient = Patient.new
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
    redirect_to patients_path, notice: '患者データが削除されました。'
  end

  private

  def patient_params
    params.require(:patient).permit(:impression_date, :note_checked, :medical_record_number, :name, :gender, :prosthesis_type_insurance, :prosthesis_type_crown, :prosthesis_type_denture, :prosthesis_site, :requester, :metal_type, :metal_amount, :trial_or_set, :set_date, :delivery_checked, :memo, :medicine_notebook, upper_right: [], upper_left: [], lower_right: [], lower_left: [], prosthesis_sites: [])
  end
end
