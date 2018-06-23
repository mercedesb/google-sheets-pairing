require './models/graph/edge'

class Node
  attr_reader :name

  def initialize(name)
    @name = name
    @edges = []
  end

  def add_edge(node, edge_value)
    @edges << Edge.new(self.name, node, edge_value)
  end

  def edges
    @edges
  end

  def match
    @edges.find { |edge| edge.matched }
  end

  def length
    @edges.length
  end
end