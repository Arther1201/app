class PatientArchivesController < ApplicationController
    def show
      @archive_patient = PatientArchive.find_by(params[:id])
    end
  end