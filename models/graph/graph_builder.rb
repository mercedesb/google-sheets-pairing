require './models/graph/graph'
require './models/graph/node'

class GraphBuilder
  def build(primary_nodes, secondary_nodes, value_calculator)
    graph = Graph.new

    primary_nodes.each do |primary|
      primary_node = Node.new(primary.name)
      graph.add_node(primary_node)

      secondary_nodes.each do |secondary|
        value = value_calculator.get_value(primary, secondary)
        secondary_node = Node.new(secondary.name)
        primary_node.add_edge(secondary_node, value)
      end
    end
    graph
  end
end
