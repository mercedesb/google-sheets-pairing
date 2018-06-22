class Proposed
  attr_reader :name
  attr_reader :preference
  attr_reader :match

  def initialize(name, preference)
    @name = name
    @preference = preference
    @match = nil
  end

  def match_with(suitor)
    @match = suitor
    suitor.match_with(self)
  end

  def matched?
    !@match.blank?
  end
end