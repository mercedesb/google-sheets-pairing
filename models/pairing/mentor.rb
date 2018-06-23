class Mentor
  attr_reader :name
  attr_reader :preferences

  def initialize(name, preferences)
    @name = name
    @preferences = preferences
  end
end