require './models/graph/edge'
require 'forwardable'

class Node
  attr_reader :name
  attr_reader :entity

  def initialize(entity)
    @entity = entity
    @name = entity.name
    @edges = []
    @match = nil
  end

  def add_edge(node, edge_value)
    @edges << Edge.new(self, node, edge_value)
  end

  def edges
    @edges
  end

  def length
    @edges.length
  end

  def to_s
    @entity.to_s
  end

  def spreadsheet_data
    @entity.spreadsheet_data
  end
end