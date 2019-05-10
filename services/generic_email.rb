# frozen_string_literal: true

require './services/google_sheets_service'
require './services/gmail_service'
require 'redcarpet'

class GenericEmail
  RECIPIENT_SHEET_RANGE = 'Recipients!A2:B2'
  EXPECTED_ROW_LENGTH = 2
  EMAIL_SHEET_NAME = 'Email Sent'
  EMAIL_SHEET_RANGE = 'A1:A2'

  def initialize(spreadsheet_id, subject = 'Dev Together')
    @spreadsheet_id = spreadsheet_id
    @subject = subject
    @sheets_service = GoogleSheetsService.new
    @mail_service = GmailService.new
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
  end

  def run
    puts 'Getting Recipient data'
    recipient_rows = recipient_data.value_ranges[0].values
    puts 'Got Recipient data'

    puts 'Getting email data'
    email_dir = File.join(File.dirname(__FILE__), '../data/email/generic')
    email_subject = @subject
    email_content = File.read("#{email_dir}/email_content.md")
    puts 'Got email data'

    recipient_rows.each do |recipient_row|
      next if recipient_row.length < EXPECTED_ROW_LENGTH

      # send email
      email = recipient_row[1]
      create_draft(recipient_row, email, email_subject, email_content)
    end

    # store email into spreadsheet for future reference
    create_email_sheet(email_subject, email_content)

    puts 'Done 💅'
  end

  private

  def recipient_data
    @recipient_data ||= @sheets_service.batch_get_values(@spreadsheet_id, [RECIPIENT_SHEET_RANGE])
  end

  def create_email_sheet(subject, body)
    puts 'Creating Email sheet for future reference'
    @sheets_service.add_sheet(@spreadsheet_id, EMAIL_SHEET_NAME)

    puts 'Updating Email sheet with email details'
    # create the update values
    update_values = []
    update_values << [].push(subject)
    update_values << [].push(body)
    @sheets_service.batch_update(@spreadsheet_id, "#{EMAIL_SHEET_NAME}!#{EMAIL_SHEET_RANGE}", update_values)
    puts 'Email sheet updates done'
  end

  def replace_recipient_data(input_string, recipient_row_data)
    name = recipient_row_data[0]
    email = recipient_row_data[1]
    # replace all tokens with appropriate data
    input_string.gsub('[NAME]', name)
                .gsub('[EMAIL]', email)
  end

  def create_draft(recipient_row_data, to, subject, body_markdown)
    body = replace_recipient_data(body_markdown, recipient_row_data)
    body = @markdown.render(body)

    puts "Creating draft for #{to}"

    body += @mail_service.signature.to_s
    # resp.message.id
    @mail_service.create_draft(to: to, from: @mail_service.email_address, subject: subject, body: body)
  end
end
