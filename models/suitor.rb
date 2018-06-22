class Suitor
  attr_reader :name
  attr_reader :preferences
  attr_reader :match

  def initialize(name, preferences)
    @name = name
    @preferences = preferences.split(", ")
    @match = nil
  end

  def match_with(proposed)
    @match = proposed
  end

  def matched?
    !@match.blank?
  end

  def to_s
    "#{@name} matched with #{@match.name} for #{match.preference}"
  end
end