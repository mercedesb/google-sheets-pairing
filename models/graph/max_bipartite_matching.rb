class MaxBipartiteMatching
  def initialize(graph)
    # residual graph
    @graph = graph 
  end

  # A DFS based recursive function
  # that returns true if a matching 
  # for vertex u is possible
  
  def bipartite_matching(mentor_node)
    mentor_node.edges.each do |mentee_edge|
      if mentee_edge.value == 1 && mentee_edge.visited == false
        mentee_edge.visited = true

        # if mentee has not been assigned a mentor or it's a match
        # set 
        if mentee_edge.matched == false || bipartite_matching(mentor_node)
          mentee_edge.matched = true
          return true
        end
      end
    end
    false
  end

  def maximum_bipartite_matching
    @graph.nodes.each do |mentor_name, mentor_node|
      bipartite_matching(mentor_node)
    end
    matches = @graph.matches.compact
    puts matches.map { |match| "#{match.head_name} -> #{match.tail.name}" }
    matches.length
  end
end
