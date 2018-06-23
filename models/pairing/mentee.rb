class Mentee
  attr_reader :name
  attr_reader :preference

  def initialize(name, preference)
    @name = name
    @preference = preference
  end
end