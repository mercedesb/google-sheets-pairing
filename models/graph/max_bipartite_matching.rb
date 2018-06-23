class MaxBipartiteMatching
  def initialize(graph)
    # residual graph
    @graph = graph 
    @mentors_length = graph.length
    @mentees_length = graph.nodes.values[0].length
  end

  # A DFS based recursive function
  # that returns true if a matching 
  # for vertex u is possible
  # 
  def bipartite_matching(mentor_node, mentors_assigned_mentees)
    mentor_node.edges.each_with_index do |mentee_edge,index|
      if mentee_edge.value == 1 && mentee_edge.visited == false
        mentee_edge.visited = true

        if mentors_assigned_mentees[index] == -1 || bipartite_matching(mentors_assigned_mentees[index], mentors_assigned_mentees)
          mentors_assigned_mentees[index] = mentor_node
          return true
        end
      end
    end
    false
  end

  def maximum_bipartite_matching
    mentors_assigned_mentees = Array.new(@mentees_length, -1)
       
    @graph.nodes.each do |mentor_name, mentor_node|
      bipartite_matching(mentor_node, mentors_assigned_mentees)
    end
    puts mentors_assigned_mentees
    mentors_assigned_mentees.count { |mentor| mentor != -1 }
  end
end
