require './services/google_sheets_service'
require './models/pairing/entity_factory'
require './models/pairing/mentor'
require './models/pairing/mentee'
require './models/graph/graph_builder'
require "./models/graph/max_bipartite_matching"
require './models/pairing/mentorship_value_calculator'

class DevTogetherMatching
  SHEET_RANGE = "B2:I50"

  def initialize(spreadsheet_id)
    @spreadsheet_id = spreadsheet_id
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
    update_pairings_in_sheets(matched_graph)
  end

  def sheet_data
    @sheet_data ||= @sheets_service.batch_get_values(@spreadsheet_id, [SHEET_RANGE])
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

  def update_pairings_in_sheets(matched_graph)
    pairing_sheet_id = add_pairing_sheet
    row_length = headers.length

    update_values = []
    update_values << headers

    matched_graph.matches.each do |pair| 
      row_value = [].push(*pair.spreadsheet_data)

      while row_value.length < row_length
        row_value.unshift("")
      end

      update_values << row_value
    end

    # x = []
    # x.push(*matched_graph.matches)
    # x << "Unmatched mentors"
    # unmatched_mentors = matched_graph.nodes - matches.map{|a| a.head}

    @sheets_service.batch_update(@spreadsheet_id, "Pairing!A1:H50", update_values)
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

  def add_pairing_sheet
    pairing_sheet_id = @sheets_service.add_sheet(@spreadsheet_id, "Pairing")
  end

  def headers
    ["Mentor Email Sent", "Mentee Email Sent", "Mentor Name", "Mentor Email", "Mentee Name", "Mentee Email", "Mentee Code", "Type of feedback"]
  end
end