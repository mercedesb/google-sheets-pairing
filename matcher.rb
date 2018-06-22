# TODO: DRY this up

require './google_sheets_service'
require './entity_factory'
require './pairing_service'

puts 'Suitor Sheet Id'
suitor_id = gets
puts 'Suitor Name Column'
suitor_name = gets.upcase
puts 'Suitor Preferences Column'
suitor_preferences = gets.upcase

puts 'Proposed Sheet Id'
proposed_id = gets
puts 'Proposed Name Column'
proposed_name = gets.upcase
puts 'Proposed Preferences Column'
proposed_preferences = gets.upcase

sheets_service = GoogleSheetsService.new
suitor_data = sheets_service.batch_get_values("1hilGyMvcKEvXd_a-ZcNtqyb93oBwCgtLmr8fHy2oVM0", ["B2:B50", "D2:D50"])
# suitor_data = sheets_service.batch_get_values("1hilGyMvcKEvXd_a-ZcNtqyb93oBwCgtLmr8fHy2oVM0", ["#{suitor_name}2:#{suitor_name}50", "#{suitor_preferences}2:#{suitor_preferences}50"])
suitor_name_data = suitor_data.value_ranges[0]
suitor_preferences_data = suitor_data.value_ranges[1]

proposed_data = sheets_service.batch_get_values("1NgOklcdKoLs1hMrtRnGidtp91rNU31xpVj-_Xr6ogcQ", ["B2:B50", "D2:D50"])
# proposed_data = sheets_service.batch_get_values("1NgOklcdKoLs1hMrtRnGidtp91rNU31xpVj-_Xr6ogcQ", ["#{proposed_name}2:#{proposed_name}50", "#{proposed_preferences}2:#{proposed_preferences}50"])
proposed_name_data = proposed_data.value_ranges[0]
proposed_preferences_data = proposed_data.value_ranges[1]

entity_factory = EntityFactory.new

suitors = []
suitor_name_data.values.each_with_index do |name, index|
  suitors << entity_factory.get_suitor(name, suitor_preferences_data.values[index])
end

proposed = []
proposed_name_data.values.each_with_index do |name, index|
  proposed << entity_factory.get_proposed(name, proposed_preferences_data.values[index])
end

require 'pry'; binding.pry
pairing_service = PairingService.new(suitors, proposed)
pairs = pairing_service.match

pairs.each do |pair|
  puts pair.to_s
end