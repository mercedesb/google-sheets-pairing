require './services/gmail_service'

# if ARGV[0]
#   sheet_id = ARGV[0]
# else
#   puts 'Sheet Id:'
#   sheet_id = gets.chomp
# end

mailer = GmailService.new
mailer.create_draft()
