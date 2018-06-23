require './models/graph/graph_builder'

class PairingService
  def initialize(mentors, mentees)
    @mentors = mentors
    @mentee = mentees
    graph_builder = GraphBuilder.new(mentors, mentees)
    #@matching_algorithm = FordFulkerson.new(graph_builder.graph)
  end

# TODO: implement maximum bipartite matching, such as Ford-Fulkerson algorithm
  def match
    available_mentors = @mentors.dup
    matched_mentors = []

    available_mentee = @mentee.dup

    available_mentee.each do |current_mentee|
      matching_mentor = available_mentors.find{ |mentor| mentor.preferences.include?(current_mentee.preference) }

      next if matching_mentor.nil?

      current_mentee.match_with(matching_mentor)
      matched_mentors << matching_mentor
      available_mentors.delete(matching_mentor)
    end

    matched_mentors
  end
end