require './services/google_sheets_service'
require './models/pairing/entity_factory'
require './models/pairing/mentor'
require './models/pairing/mentee'
require './models/graph/graph_builder'
require "./models/graph/max_bipartite_matching"
require './models/pairing/mentorship_value_calculator'

class DevTogetherMatching
  SHEET_RANGE = "B2:I50"

  def initialize(sheet_id)
    @sheet_id = sheet_id
    @sheets_service = GoogleSheetsService.new
    @entity_factory = EntityFactory.new
    @value_calculator = MentorshipValueCalculator.new
    @graph_builder = GraphBuilder.new
    @matching_algorithm = MaxBipartiteMatching.new
  end

  def run
    attendee_data = sheet_data.value_ranges[0].values
    entities(attendee_data)

    mentorship_graph = @graph_builder.build(mentors, mentees, @value_calculator)
    matched_graph = @matching_algorithm.match(mentorship_graph)
    output(matched_graph.matches)
  end

  def sheet_data
    @sheet_data ||= @sheets_service.batch_get_values(@sheet_id, [SHEET_RANGE])
  end

  def entities(data)
    return @entities if defined? @entities
    @entities = []
    data.each do |data_row|
      @entities << @entity_factory.get_entity(data_row)
    end
    @entities
  end

  def mentors
    @entities.select { |e| e.is_a?(Mentor) }
  end

  def mentees
    @entities.select { |e| e.is_a?(Mentee) }
  end

  def output(matches)
    puts
    puts 'Pairs'
    puts matches.map { |pair| pair.to_s }
    puts
    puts 'Unmatched Mentors:'
    puts mentors.map{|a| a.name} - matches.map{|a| a.head.name}
    puts
    puts 'Unmatched Mentees:'
    puts mentees.map{|a| a.name} - matches.map{|a| a.tail.name}
  end
end