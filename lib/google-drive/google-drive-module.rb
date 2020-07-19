module GoogleDriveModule
  require 'bundler'
  Bundler.require

  def first_try
    session     = GoogleDrive::Session.from_service_account_key("config/api-keys/google-sheets-keys.json")
    spreadsheet = session.spreadsheet_by_title("CATALAGO DE PRODUCTOS NADRO AL 200712")
    worksheet   = spreadsheet.worksheets.first
    worksheet.rows.each { |row| puts row.first(6).join(" | ") }
  end
end