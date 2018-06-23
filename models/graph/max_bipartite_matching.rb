class MaxBipartiteMatching
  def initialize(graph)
    # residual graph
    @graph = graph 
    @mentors_length = graph.length
    @mentees_length = graph[0].length
  end

  # A DFS based recursive function
  # that returns true if a matching 
  # for vertex u is possible
  # 
  def bipartite_matching(mentor_index, mentors_assigned_mentees, mentees_not_seen_for_current_mentor)
    @graph[mentor_index].each_with_index do |mentee,index|
      if mentee == 1 && mentees_not_seen_for_current_mentor[index] == false
        mentees_not_seen_for_current_mentor[index] = true

        if mentors_assigned_mentees[index] == -1 || bipartite_matching(mentors_assigned_mentees[index], mentors_assigned_mentees, mentees_not_seen_for_current_mentor)
          mentors_assigned_mentees[index] = mentor_index
          return true
        end
      end
    end
    false
  end

  def maximum_bipartite_matching
    mentors_assigned_mentees = Array.new(@mentees_length, -1)
       
    count_of_mentors_assigned_mentees = 0
    @graph.each_with_index do |mentor ,index|
      mentees_not_seen_for_current_mentor = Array.new(@mentees_length, false)

      if bipartite_matching(index, mentors_assigned_mentees, mentees_not_seen_for_current_mentor)
        count_of_mentors_assigned_mentees = count_of_mentors_assigned_mentees + 1
      end
    end
    puts mentors_assigned_mentees
    count_of_mentors_assigned_mentees
  end
end
