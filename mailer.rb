require './services/dev_together_email'

if ARGV[0]
  sheet_id = ARGV[0]
else
  puts 'Sheet Id:'
  sheet_id = gets.chomp
end

dev_together_email = DevTogetherEmail.new(sheet_id)
dev_together_email.run
