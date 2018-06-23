require './models/graph/graph'
require './models/graph/node'

class GraphBuilder
  def initialize(mentors, mentees)
    @mentors = mentors
    @mentees = mentees
  end

  def build
    graph = Graph.new

    @mentors.each do |mentor|
      mentor_node = Node.new(mentor.name)
      graph.add_node(mentor_node)

      @mentees.each do |mentee|
        value = mentor.preferences.include?(mentee.preference) ? 1 : 0
        mentee_node = Node.new(mentee.name)
        mentor_node.add_edge(mentee_node, value)
      end
    end
    graph
  end
end
