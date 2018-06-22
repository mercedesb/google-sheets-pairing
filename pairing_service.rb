class PairingService
  def initialize(suitors, proposed)
    @suitors = suitors
    @proposed = proposed
  end

# TODO: implement maximum bipartite matching, such as Ford-Fulkerson algorithm
  def match
    available_suitors = @suitors.dup
    matched_suitors = []

    available_proposed = @proposed.dup

    available_proposed.each do |current_proposed|
      matching_suitor = available_suitors.find{ |suitor| suitor.preferences.include?(current_proposed.preference) }

      next if matching_suitor.nil?

      current_proposed.match_with(matching_suitor)
      matched_suitors << matching_suitor
      available_suitors.delete(matching_suitor)
    end

    matched_suitors
  end
end