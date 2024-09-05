class Patient < ApplicationRecord
  serialize :upper_right, Array
  serialize :upper_left, Array
  serialize :lower_right, Array
  serialize :lower_left, Array
  mount_uploaders :images, ImageUploader
  serialize :images, JSON

  validates :prosthesis_type_insurance, presence: true, if: -> { prosthesis_type_crown.blank? && prosthesis_type_denture.blank? }
  validates :prosthesis_type_crown, presence: true, if: -> { prosthesis_type_insurance.blank? && prosthesis_type_denture.blank? }
  validates :prosthesis_type_denture, presence: true, if: -> { prosthesis_type_insurance.blank? && prosthesis_type_crown.blank? }
end