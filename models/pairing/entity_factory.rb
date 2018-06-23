require './models/pairing/mentor'
require './models/pairing/mentee'

class EntityFactory

  def get_mentor(name_data, preferences_data)
    Mentor.new(name_data[0], preferences_data[0].split(", "))
  end

  def get_mentee(name_data, preference_data)
    Mentee.new(name_data[0], preference_data[0])
  end

end