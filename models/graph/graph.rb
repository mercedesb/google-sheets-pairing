require './models/graph/edge'

class Graph
  SOURCE_NAME = "source"
  SINK_NAME = "sink"

  attr_reader :nodes

  def initialize
    @nodes = {}
  end

  def add_node(node)
    @nodes[node.name] = node
  end

  def [](name)
    @nodes[name]
  end

  def length
    @nodes.length
  end

  def matches
    matches = []
    @nodes.each  do |node_name, node|
      matches << node.match
    end
    matches
  end
  
  # def add_edge(predecessor, successor)
  #   @nodes[predecessor.name].add_edge(@nodes[successor.name])
  # end


  # def edges
  #   edges = []
  #   @nodes.each do |name, node|
  #     node.edges.each do |edge|
  #       edges << Edge.new(node, edge)
  #     end
  #   end
  #   edges
  # end

  # def source
  #   @nodes[SOURCE_NAME]
  # end

  # def sink
  #   @nodes[SINK_NAME]
  # end

end