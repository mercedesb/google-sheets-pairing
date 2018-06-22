# TODO: DRY this up

require './services/google_sheets_service'
require './models/entity_factory'
require './services/pairing_service'

puts 'Mentor Sheet Id'
mentor_id = gets
puts 'Mentor Name Column'
mentor_name = gets.upcase
puts 'Mentor Preferences Column'
mentor_preferences = gets.upcase

puts 'Mentee Sheet Id'
mentee_id = gets
puts 'Mentee Name Column'
mentee_name = gets.upcase
puts 'Mentee Preferences Column'
mentee_preferences = gets.upcase

sheets_service = GoogleSheetsService.new
mentor_data = sheets_service.batch_get_values("1hilGyMvcKEvXd_a-ZcNtqyb93oBwCgtLmr8fHy2oVM0", ["B2:B50", "D2:D50"])
# mentor_data = sheets_service.batch_get_values("1hilGyMvcKEvXd_a-ZcNtqyb93oBwCgtLmr8fHy2oVM0", ["#{mentor_name}2:#{mentor_name}50", "#{mentor_preferences}2:#{mentor_preferences}50"])
mentor_name_data = mentor_data.value_ranges[0]
mentor_preferences_data = mentor_data.value_ranges[1]

mentee_data = sheets_service.batch_get_values("1NgOklcdKoLs1hMrtRnGidtp91rNU31xpVj-_Xr6ogcQ", ["B2:B50", "D2:D50"])
# mentee_data = sheets_service.batch_get_values("1NgOklcdKoLs1hMrtRnGidtp91rNU31xpVj-_Xr6ogcQ", ["#{mentee_name}2:#{mentee_name}50", "#{mentee_preferences}2:#{mentee_preferences}50"])
mentee_name_data = mentee_data.value_ranges[0]
mentee_preferences_data = mentee_data.value_ranges[1]

entity_factory = EntityFactory.new

mentors = []
mentor_name_data.values.each_with_index do |name, index|
  mentors << entity_factory.get_mentor(name, mentor_preferences_data.values[index])
end

mentee = []
mentee_name_data.values.each_with_index do |name, index|
  mentee << entity_factory.get_mentee(name, mentee_preferences_data.values[index])
end

require 'pry'; binding.pry
pairing_service = PairingService.new(mentors, mentee)
pairs = pairing_service.match

pairs.each do |pair|
  puts pair.to_s
end