class ChangeImageToImagesInPatients < ActiveRecord::Migration[7.0]
  def change
    rename_column :patients, :image, :images
    change_column :patients, :images, :text
  end
end
