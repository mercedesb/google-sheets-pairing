class Graph
  attr_reader :nodes

  def initialize
    @nodes = {}
  end

  def add_node(node)
    @nodes[node.name] = node
  end

  def add_edge(predecessor, successor)
    @nodes[predecessor.name].add_edge(@nodes[successor.name])
  end

  def [](name)
    @nodes[name]
  end

  def edges
    edges = []
    @nodes.each do |name, node|
      node.edges.each do |edge|
        edges << "#{node.name} : #{edge.name}"
      end
    end
    edges
  end

end