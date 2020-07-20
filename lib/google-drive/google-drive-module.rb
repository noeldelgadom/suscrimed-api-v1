module GoogleDriveModule
  require 'bundler'
  Bundler.require

  # reload! ; load "lib/google-drive/google-drive-module.rb" ; include GoogleDriveModule ; first_try

  def first_try
    session     = GoogleDrive::Session.from_service_account_key("config/api-keys/google-sheets-key.json")
    spreadsheet = session.spreadsheet_by_title("Practice API")
    worksheet   = spreadsheet.worksheets.first
    worksheet.rows.first(3).each_with_index do |row, i|
      worksheet[i + 1,2] = i + 1
    end

    worksheet.save
  end
end