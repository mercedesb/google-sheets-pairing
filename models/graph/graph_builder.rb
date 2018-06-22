require './models/graph/graph'
require './models/graph/node'

class GraphBuilder
  SOURCE_NAME = "source"
  SINK_NAME = "sink"
  def initialize(mentors, mentees)
    @mentors = mentors
    @mentees = mentees
  end

  def build
    graph = Graph.new
    source = graph.add_node(Node.new(SOURCE_NAME, source: true))
    sink = graph.add_node(Node.new(SINK_NAME, sink: true))

    @mentors.each do |mentor|
      mentor_node = Node.new(mentor.name)
      graph.add_node(mentor_node)
      graph.add_edge(source, mentor_node)

      matched_mentees = @mentees.find_all { |mentee| mentor.preferences.include?(mentee.preference) }
      matched_mentees.each do | mentee |
        mentee_node = graph[mentee.name]
        if mentee_node.nil?
          mentee_node = Node.new(mentee.name)
          graph.add_node(mentee_node)
          graph.add_edge(mentee_node, sink)
        end

        graph.add_edge(mentor_node, mentee_node)
      end
    end

    graph
  end
end
