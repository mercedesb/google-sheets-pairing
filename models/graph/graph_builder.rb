require './models/graph/graph'
require './models/graph/node'

class GraphBuilder
  def initialize(mentors, mentees)
    @mentors = mentors
    @mentees = mentees
  end

  # def build
  #   graph = Graph.new

  #   @mentors.each do |mentor|
  #     mentor_node = Node.new(mentor.name)
  #     graph.add_node(mentor_node)
  #     graph.add_edge(source, mentor_node)

  #     matched_mentees = @mentees.find_all { |mentee| mentor.preferences.include?(mentee.preference) }
  #     matched_mentees.each do | mentee |
  #       mentee_node = graph[mentee.name]
  #       if mentee_node.nil?
  #         mentee_node = Node.new(mentee.name)
  #         graph.add_node(mentee_node)
  #       end

  #       graph.add_edge(mentor_node, mentee_node)
  #     end
  #   end

  #   graph
  # end
  
  def build
    graph = []
    @mentors.each do |mentor|
      mentor_row = []
      @mentees.each do |mentee|
        value = mentor.preferences.include?(mentee.preference) ? 1 : 0
        mentor_row << value
      end
      graph << mentor_row
    end
    graph
  end
end
