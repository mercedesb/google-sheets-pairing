# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# [START sheets_quickstart]
require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class GoogleSheetsService

  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
  CLIENT_SECRETS_PATH = 'client_secret.json'.freeze
  CREDENTIALS_PATH = 'token.yaml'.freeze
  SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS

  def initialize
    client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)

    @authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    @user_id = 'default'

    # Initialize the API
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.authorization = authorize
  end

  ##
  # Ensure valid credentials, either by restoring from the saved credentials
  # files or intitiating an OAuth2 authorization. If authorization is required,
  # the user's default browser will be launched to approve the request.
  #
  # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
  def authorize
    credentials = @authorizer.get_credentials(@user_id)
    if credentials.nil?
      url = @authorizer.get_authorization_url(base_url: OOB_URI)
      puts 'Open the following URL in the browser and enter the ' \
           "resulting code after authorization:\n" + url
      code = gets
      credentials = @authorizer.get_and_store_credentials_from_code(
        user_id: @user_id, code: code, base_url: OOB_URI
      )
    end
    credentials
  end

  def get_values(spreadsheet_id, range_name)
    result = @service.get_spreadsheet_values(spreadsheet_id, range_name)
    num_rows = result.values ? result.values.length : 0
    puts "#{num_rows} rows received."
    result
  end

  def batch_get_values(spreadsheet_id, range_names)
    result = @service.batch_get_spreadsheet_values(spreadsheet_id,
                                                  ranges: range_names,
                                                  major_dimension: "ROWS")
    puts "#{result.value_ranges.length} ranges retrieved."
    result
  end

  def batch_update(spreadsheet_id, range, values)
    data= [
      {
        range: range,
        majorDimension: "ROWS",
        values: values
      }
    ]
    request_body = Google::Apis::SheetsV4::BatchUpdateValuesRequest.new(value_input_option: "USER_ENTERED", data: data)
    response = @service.batch_update_values(spreadsheet_id, request_body)  
  end

  def add_sheet(spreadsheet_id, title)
    add_sheet_request = Google::Apis::SheetsV4::AddSheetRequest.new
    add_sheet_request.properties = Google::Apis::SheetsV4::SheetProperties.new(title: title)
    
    batch_update_spreadsheet_request_object = [ { add_sheet: add_sheet_request } ] 
    batch_update_spreadsheet_request = Google::Apis::SheetsV4::BatchUpdateSpreadsheetRequest.new(requests: batch_update_spreadsheet_request_object)
    begin
      response = @service.batch_update_spreadsheet(spreadsheet_id, batch_update_spreadsheet_request)
      response.replies[0].add_sheet.properties.sheet_id
    rescue Google::Apis::ClientError
      response = @service.get_spreadsheet(spreadsheet_id, fields: "sheets.properties.sheetId,sheets.properties.title")
      sheet = response.sheets.find { |sheet| sheet.properties.title == title }
      sheet.properties.sheet_id
    end
  end

  def update_row(sheet_id, start_row_index, start_column_index, row_values)
    grid_range = Google::Apis::SheetsV4::GridRange.new(start_row_index: start_row_index, start_column_index: start_column_index, sheet_id: sheet_id)
    grid_coordinate = Google::Apis::SheetsV4::GridCoordinate.new(row_index: start_row_index, column_index: start_column_index, sheet_id: sheet_id)
    
    cell_data = row_values.map { |value| Google::Apis::SheetsV4::CellData.new(user_entered_value: Google::Apis::SheetsV4::ExtendedValue.new(string_value: value)) }
    row_data = Google::Apis::SheetsV4::RowData.new(values: cell_data)
    
    update_cells_request = Google::Apis::SheetsV4::UpdateCellsRequest.new(range: grid_range, start: grid_coordinate, rows: row_data, fields: "*")
    { updateCells: update_cells_request }
  end
end