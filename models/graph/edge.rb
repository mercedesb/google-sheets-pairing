class Edge
  attr_reader :head_name
  attr_reader :tail
  attr_reader :value
  attr_accessor :visited
  attr_accessor :matched

  def initialize(head_name, tail, value)
    @head_name = head_name
    @tail = tail
    @value = value
    @visited = false
    @matched = false
  end
end