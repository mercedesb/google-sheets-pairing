class Edge
  attr_reader :head
  attr_reader :tail
  
  def initialize(head, tail)
    @head = head
    @tail = tail
  end
end