class PatientArchive < ApplicationRecord
    belongs_to :patient, class_name: 'Patient', foreign_key: 'patient_id'
end
