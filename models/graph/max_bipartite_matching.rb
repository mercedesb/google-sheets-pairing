# frozen_string_literal: true

class MaxBipartiteMatching
  def match(graph)
    # residual graph
    @graph = graph
    maximum_bipartite_matching
  end

  def maximum_bipartite_matching
    matched_edges = Array.new(@graph.nodes.values[0].length, false)

    @graph.nodes.each do |_parent_name, parent_node|
      bipartite_matching(parent_node, matched_edges)
    end

    @graph.matches = matched_edges.reject { |match| match == false }
    @graph
  end

  # A DFS based recursive function that returns true if a matching
  # for vertex parent_node is possible
  def bipartite_matching(parent_node, matched_edges)
    parent_node.edges.each_with_index do |child_edge, index|
      next unless child_edge.value == 1 && child_edge.visited == false
      child_edge.visited = true

      # if child_edge has not been matched or it's a match with the parent_node
      if !matched_edges[index] || bipartite_matching(@graph[matched_edges[index].head.name], matched_edges)
        matched_edges[index] = child_edge
        return true
      end
    end
    false
  end
end
