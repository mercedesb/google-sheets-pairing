class Mentor
  attr_reader :name
  attr_reader :preferences
  attr_reader :match

  def initialize(name, preferences)
    @name = name
    @preferences = preferences
    @match = nil
  end

  def match_with(mentee)
    @match = mentee
  end

  def matched?
    !@match.blank?
  end

  def to_s
    "#{@name} matched with #{@match.name} for #{match.preference}"
  end
end