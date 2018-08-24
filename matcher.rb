require './services/dev_together_matching'

if ARGV[0]
  sheet_id = ARGV[0]
else
  puts 'Sheet Id:'
  sheet_id = gets.chomp
end

matcher = DevTogetherMatching.new(sheet_id)
matches = matcher.run
