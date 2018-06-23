require './models/graph/graph_builder'
require './models/pairing/mentorship_value_calculator'

class PairingService
  def initialize(mentors, mentees)
    @mentors = mentors
    @mentee = mentees
    value_calculator = MentorshipValueCalculator.new
    graph_builder = GraphBuilder.new(mentors, mentees, value_calculator)
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