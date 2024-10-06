crumb :root do
  link "トップページ", root_path
end

crumb :login do
  link "ログイン", login_path
  parent :root
end

crumb :signup do
  link "新規登録", signup_path
  parent :root
end

crumb :patients do
  link "患者一覧", patients_path
end

crumb :patient do |patient|
  link "患者詳細", patient_path(patient)
  parent :patients
end

crumb :edit_patient do |patient|
  link "患者編集", edit_patient_path(patient)
  parent :patient, patient
end

crumb :new_patient do
  link "患者登録", new_patient_path
  parent :patients
end

crumb :search_form do
  link "患者検索", search_form_patients_path
  parent :patients
end

crumb :search_results do
  link "検索結果", search_patients_path
  parent :search_form
end

crumb :chat_rooms do
  link "チャットルーム一覧", chat_rooms_path
  parent :patients
end

crumb :chat_room do |chat_room|
  if chat_room.present?
    link chat_room.name, chat_room_path(chat_room)
    parent :chat_rooms
  else
    link "チャットルーム", chat_rooms_path
    parent :chat_rooms
  end
end

crumb :calendar do
  link "セット日カレンダー", calendar_patients_path
  parent :patients
end

crumb :prostheses do
  link "歯科用語", prostheses_path
  parent :patients
end

crumb :prosthesis_list do |letter|
  link "歯科用語各行", list_prostheses_path(letter: letter)
  parent :prostheses
end

crumb :prosthesis_detail do |prosthesis|
  link prosthesis.name, prosthesis_path(prosthesis)
  parent :prosthesis_list, prosthesis.name[0] 
end

crumb :shipments do
  link "集荷情報一覧", shipments_path
  parent :patients
end

crumb :models do
  link "模型管理", models_path
  parent :patients
end

crumb :new_model do
  link "模型作成", new_model_path
  parent :models
end

crumb :supplies do
  link "物品一覧", supplies_path
  parent :patients
end

crumb :new_supply do
  link "物品作成", new_supply_path
  parent :supplies
end

crumb :show_supply do
  link "物品詳細", supply_path
  parent :new_supply
end

crumb :archives_supplies do
  link "物品アーカイブ一覧", archives_supplies_path
  parent :supplies
end

crumb :show_archive_supply do |supply_archive|
  if supply_archive
    link "#{supply_archive.year}年の物品データ", show_archive_supply_path(supply_archive.id)
  else
    link "物品データ", archives_supplies_path
  end
  parent :archives_supplies
end

crumb :archives do 
  link "患者のアーカイブ", archives_patients_path
  parent :patients
end

crumb :show_archive_patients do |patient_archive|
  if patient_archive.present? && patient_archive.archived_year.present?
    link "#{patient_archive.archived_year}年の患者データ", show_archive_patients_path(id: patient_archive.id)
  else
    link "患者データ", archives_patients_path
  end
  parent :archives
end

crumb :archive_patient_show do |patient_archive|
  if patient_archive.present?
    link "アーカイブ患者詳細", show_archive_patients_path(year: patient_archive.archived_year)
    parent :show_archive_patients, patient_archive
  else
    link "患者データ", archives_patients_path
  end
end

crumb :metals do
  link "メタル一覧", metals_path
  parent :patients
end

crumb :metals_new do
  link "メタルの新規登録", new_metal_path
  parent :metals
end

crumb :metals_show do |metal|
  link "購入履歴", metal_path(metal)
  parent :metals
end


    
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).