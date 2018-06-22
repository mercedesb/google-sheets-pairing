class Node

  attr_reader :name

  def initialize(name, source: false, sink: false)
    @name = name
    @successors = []
  end

  def add_edge(successor)
    @successors << successor
  end

  def to_s
    "#{@name} -> [#{@successors.map(&:name).join(' ')}]"
  end

  def edges
    @successors
  end

end