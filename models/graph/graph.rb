class Graph
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
end