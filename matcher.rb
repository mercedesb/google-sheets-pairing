# TODO: DRY this up

require './services/google_sheets_service'
require './services/dev_together_matching'
require './services/pairing_service'

sheets_service = GoogleSheetsService.new

puts 'Mentor Sheet Id:'
mentor_id = gets.chomp

# 1hilGyMvcKEvXd_a-ZcNtqyb93oBwCgtLmr8fHy2oVM0
mentor_data = sheets_service.batch_get_values(mentor_id, [DevTogetherMatching::MENTOR_ID_RANGE, DevTogetherMatching::MENTOR_PREFERENCES_RANGE])
mentor_name_data = mentor_data.value_ranges[0]
mentor_preferences_data = mentor_data.value_ranges[1]

puts 'Mentee Sheet Id:'
mentee_id = gets.chomp

# 1NgOklcdKoLs1hMrtRnGidtp91rNU31xpVj-_Xr6ogcQ
mentee_data = sheets_service.batch_get_values(mentee_id, [DevTogetherMatching::MENTEE_ID_RANGE, DevTogetherMatching::MENTEE_PREFERENCE_RANGE])
mentee_name_data = mentee_data.value_ranges[0]
mentee_preferences_data = mentee_data.value_ranges[1]

mentors = DevTogetherMatching.get_mentors(mentor_name_data, mentor_preferences_data)
mentees = DevTogetherMatching.get_mentees(mentee_name_data, mentee_preferences_data)

pairing_service = PairingService.new(mentors, mentees)
pairing_graph = pairing_service.pair

puts
puts 'Pairs'
puts pairing_graph.matches.map { |pair| pair.to_s }
puts
puts 'Unmatched Mentors:'
puts mentors.map{|a| a.name} - pairing_graph.matches.map{|a| a.head_name}
puts
puts 'Unmatched Mentees:'
puts mentees.map{|a| a.name} - pairing_graph.matches.map{|a| a.tail.name}
