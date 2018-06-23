class Node

  attr_reader :name

  def initialize(name)
    @name = name
    @successors = []
  end

  def [](index)
    @successors[index]
  end

  def add_edge(node, edge_value)
    edge = Edge.new(self.name, node, edge_value)
    @successors << edge
  end

  def to_s
    "#{@name}"
  end

  def edges
    @successors
  end

  def length
    @successors.length
  end

end