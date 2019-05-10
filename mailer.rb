# frozen_string_literal: true

require 'optparse'
require './services/dev_together_pairing_email'
require './services/generic_email'

if ARGV[0]
  sheet_id = ARGV[0]
else
  puts 'Sheet Id:'
  sheet_id = gets.chomp
end

options = {}

OptionParser.new do |opt|
  opt.on('-g', '--general', 'Send general email') { |_o| options[:send_general_email] = true }
  opt.on('-s', '--subject SUBJECT', 'The email\'s subject') { |o| options[:subject] = o }
end.parse!

email_sender = if options[:send_general_email]
                 GenericEmail.new(sheet_id, options[:subject])
               else
                 DevTogetherPairingEmail.new(sheet_id)
               end

email_sender.run
