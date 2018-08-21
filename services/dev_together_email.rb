require './services/google_sheets_service'
require './services/gmail_service'

class DevTogetherEmail
  PAIRING_SHEET_RANGE = "Pairing!A2:H50"
  MENTOR_EMAIL_SHEET_RANGE = "Mentor Email!A1:A2"
  MENTEE_EMAIL_SHEET_RANGE = "Mentee Email!A1:A2"

  def initialize(spreadsheet_id)
    @spreadsheet_id = spreadsheet_id
    @sheets_service = GoogleSheetsService.new
    @mail_service = GmailService.new
  end

  def run
    puts "Getting Pair data"
    rows = pairing_data.value_ranges[0].values
    require 'pry'; binding.pry
    puts "Got Pair data"

    puts "Getting Mentor email data"
    mentor_subject = mentor_email_data.value_ranges[0].values[0]
    mentor_body_string_format = mentor_email_data.value_ranges[1].values[0]
    puts "Got Mentor email data"

    puts "Getting Mentee email data"
    mentee_subject = mentee_email_data.value_ranges[0].values[0]
    mentee_body_string_format = mentee_email_data.value_ranges[1].values[0]
    puts "Got Mentee email data"
    require 'pry'; binding.pry

    rows.each do |row|
    require 'pry'; binding.pry
      mentor_name = row[2]
      mentor_email = row[3]
      mentee_name = row[4]
      mentee_email = row[5]
      mentee_code = row[6]
      mentee_feedback_requested = row[7]

      # string interpolate body with row inputs
      mentor_body = mentor_body_string_format.gsub('[MENTOR_NAME]', mentor_name)
                                             .gsub('[MENTOR_EMAIL]', mentor_email)
                                             .gsub('[MENTEE_NAME]', mentee_name)
                                             .gsub('[MENTEE_EMAIL]', mentee_email)
                                             .gsub('[MENTEE_CODE]', mentee_code)
                                             .gsub('[MENTEE_FEEDBACK]', mentee_feedback)

      # read to from row inputs
      to = mentor_email
      @mail_service.create_draft(to: to, from: "devtogetherchi@gmail.com", subject: mentor_subject, body: mentor_body)

      mentee_body = mentee_body_string_format.gsub('[MENTOR_NAME]', mentor_name)
                                             .gsub('[MENTOR_EMAIL]', mentor_email)
                                             .gsub('[MENTEE_NAME]', mentee_name)
                                             .gsub('[MENTEE_EMAIL]', mentee_email)
                                             .gsub('[MENTEE_CODE]', mentee_code)
                                             .gsub('[MENTEE_FEEDBACK]', mentee_feedback)
      
      to = mentor_email
      @mail_service.create_draft(to: to, from: "devtogetherchi@gmail.com", subject: mentee_subject, body: mentee_body)

    end
  end

  private

  def pairing_data
    @pairing_data ||= @sheets_service.batch_get_values(@spreadsheet_id, [PAIRING_SHEET_RANGE])
  end

  def mentor_email_data
    @mentor_email_data ||= @sheets_service.batch_get_values(@spreadsheet_id, [MENTOR_EMAIL_SHEET_RANGE])
  end

  def mentee_email_data
    @mentee_email_data ||= @sheets_service.batch_get_values(@spreadsheet_id, [MENTEE_EMAIL_SHEET_RANGE])
  end
end