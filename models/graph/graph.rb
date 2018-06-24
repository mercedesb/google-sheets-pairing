class Graph
  attr_reader :nodes
  attr_accessor :matches

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
end