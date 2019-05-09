# frozen_string_literal: true

class Edge
  attr_reader :head
  attr_reader :tail
  attr_reader :value
  attr_accessor :visited

  def initialize(head_node, tail_node, value)
    @head = head_node
    @tail = tail_node
    @value = value
    @visited = false
  end

  def to_s
    "#{head}, #{tail}"
  end

  def spreadsheet_data
    head.spreadsheet_data.push(*tail.spreadsheet_data)
  end
end
