require './suitor'
require './proposed'

class EntityFactory

  def get_suitor(name_data, preferences_data)
    Suitor.new(name_data[0], preferences_data[0].split(", "))
  end

  def get_proposed(name_data, preference_data)
    Proposed.new(name_data[0], preference_data[0])
  end

end