class MaxBipartiteMatching
  def initialize(graph)
    # residual graph
    @graph = graph 
  end

  # A DFS based recursive function
  # that returns true if a matching 
  # for vertex u is possible
  
  def bipartite_matching(parent_node)
    parent_node.edges.each do |child_edge|
      if child_edge.value == 1 && child_edge.visited == false
        child_edge.visited = true

        # if mentee has not been assigned a mentor or it's a match
        # set 
        if child_edge.matched == false || bipartite_matching(parent_node)
          child_edge.matched = true
          return true
        end
      end
    end
    false
  end

  def maximum_bipartite_matching
    @graph.nodes.each do |parent_name, parent_node|
      bipartite_matching(parent_node)
    end
    matches = @graph.matches.compact
    puts matches.map { |match| "#{match.head_name} -> #{match.tail.name}" }
    matches.length
  end
end
