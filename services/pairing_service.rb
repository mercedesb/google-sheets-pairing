require './models/graph/graph_builder'
require "./models/graph/max_bipartite_matching"
require './models/pairing/mentorship_value_calculator'

class PairingService
  def initialize(mentors, mentees)
    mentors = mentors
    mentee = mentees
    value_calculator = MentorshipValueCalculator.new
    @graph_builder = GraphBuilder.new(mentors, mentees, value_calculator)
  end

  def pair
    mentorship_graph = @graph_builder.build
    matching_algorithm = MaxBipartiteMatching.new(mentorship_graph)
    matches = matching_algorithm.match
  end
end