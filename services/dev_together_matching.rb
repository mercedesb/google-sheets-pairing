require './services/google_sheets_service'
require './models/pairing/entity_factory'
require './models/graph/graph_builder'
require "./models/graph/max_bipartite_matching"
require './models/pairing/mentorship_value_calculator'

class DevTogetherMatching
  MENTOR_ID_RANGE = "C2:C50"
  MENTOR_PREFERENCES_RANGE = "D2:D50"
  MENTEE_ID_RANGE = "C2:C50"
  MENTEE_PREFERENCE_RANGE = "F2:F50"

  def initialize(mentor_sheet_id, mentee_sheet_id)
    @mentor_sheet_id = mentor_sheet_id
    @mentee_sheet_id = mentee_sheet_id
    @sheets_service = GoogleSheetsService.new
    @entity_factory = EntityFactory.new
    @value_calculator = MentorshipValueCalculator.new
    @mentors = []
    @mentees = []
  end

  def run
    @mentors = mentors(mentor_data.value_ranges[0], mentor_data.value_ranges[1])
    @mentees =  mentees(mentee_data.value_ranges[0], mentee_data.value_ranges[1])

    graph_builder = GraphBuilder.new(@mentors, @mentees, @value_calculator)
    mentorship_graph = graph_builder.build
    matching_algorithm = MaxBipartiteMatching.new(mentorship_graph)
    graph = matching_algorithm.match
    output(graph.matches)
  end

  def mentor_data
    @mentor_data ||= @sheets_service.batch_get_values(@mentor_sheet_id, [MENTOR_ID_RANGE, MENTOR_PREFERENCES_RANGE])
  end

  def mentee_data
    @mentee_data ||= @sheets_service.batch_get_values(@mentee_sheet_id, [MENTEE_ID_RANGE, MENTEE_PREFERENCE_RANGE])
  end

  def mentors(name_data, preferences_data)
    mentors = []
    name_data.values.each_with_index do |name, index|
      mentors << @entity_factory.get_mentor(name, preferences_data.values[index])
    end
    mentors
  end

  def mentees(name_data, preference_data)
    mentees = []
    name_data.values.each_with_index do |name, index|
      mentees << @entity_factory.get_mentee(name, preference_data.values[index])
    end
    mentees
  end

  def output(matches)
    puts
    puts 'Pairs'
    puts matches.map { |pair| pair.to_s }
    puts
    puts 'Unmatched Mentors:'
    puts @mentors.map{|a| a.name} - matches.map{|a| a.head_name}
    puts
    puts 'Unmatched Mentees:'
    puts @mentees.map{|a| a.name} - matches.map{|a| a.tail.name}
  end
end