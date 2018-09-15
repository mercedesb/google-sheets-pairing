require './services/google_sheets_service'
require './services/gmail_service'
require 'redcarpet'

class DevTogetherEmail
  PAIRING_SHEET_RANGE = "Pairing!A2:H50"
  EXPECTED_ROW_LENGTH = 8
  MENTOR_EMAIL_SHEET_RANGE = "Mentor Email!A1:A2"
  MENTEE_EMAIL_SHEET_RANGE = "Mentee Email!A1:A2"

  def initialize(spreadsheet_id)
    @spreadsheet_id = spreadsheet_id
    @sheets_service = GoogleSheetsService.new
    @mail_service = GmailService.new
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
  end

  def run
    puts "Getting Pair data"
    rows = pairing_data.value_ranges[0].values
    puts "Got Pair data"
    
    puts "Getting Mentor email data"
    mentor_subject = mentor_email_data.value_ranges[0].values[0][0]
    mentor_body_format_string = mentor_email_data.value_ranges[0].values[1][0]
    puts "Got Mentor email data"
    
    puts "Getting Mentee email data"
    mentee_subject = mentee_email_data.value_ranges[0].values[0][0]
    mentee_body_format_string = mentee_email_data.value_ranges[0].values[1][0]
    puts "Got Mentee email data"

    rows.each do |row|
      next if row.length < EXPECTED_ROW_LENGTH

      #send mentor email
      mentor_email = row[3]
      create_draft(row, mentor_email, mentor_subject, mentor_body_format_string)
      
      #send mentee email
      mentee_email = row[5]
      create_draft(row, mentee_email, mentee_subject, mentee_body_format_string)
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

  def replace_pairing_data(input_string, row_data)
    mentor_name = row_data[2]
    mentor_email = row_data[3]
    mentee_name = row_data[4]
    mentee_email = row_data[5]
    mentee_code = row_data[6]
    mentee_feedback_requested = row_data[7]

    input_string.gsub('[MENTOR_NAME]', mentor_name)
                .gsub('[MENTOR_EMAIL]', mentor_email)
                .gsub('[MENTEE_NAME]', mentee_name)
                .gsub('[MENTEE_EMAIL]', mentee_email)
                .gsub('[MENTEE_CODE]', mentee_code)
                .gsub('[MENTEE_FEEDBACK]', mentee_feedback_requested)
  end

  def create_draft(row_data, to, subject_format_string, body_format_string)
    subject = replace_pairing_data(subject_format_string, row_data)
    body = replace_pairing_data(body_format_string, row_data)
    body = @markdown.render(body)

    puts "Creating draft for #{to}"

    body += "#{@mail_service.signature}"
    #resp.message.id
    resp = @mail_service.create_draft(to: to, from: @mail_service.email_address, subject: subject, body: body)
  end
end