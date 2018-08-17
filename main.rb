require './services/dev_together_matching'

if ARGV[0]
  first_sheet_id = ARGV[0]
else
  puts 'First Sheet Id:'
  first_sheet_id = gets.chomp
end

if ARGV[1]
  second_sheet_id = ARGV[1]
else
  puts 'Second Sheet Id:'
  second_sheet_id = gets.chomp
end

matcher = DevTogetherMatching.new(first_sheet_id, second_sheet_id)
matches = matcher.run
