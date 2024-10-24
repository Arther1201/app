class PatientArchivesController < ApplicationController
  def show
    @archive_patient = PatientArchive.find(params[:id])
  end
end