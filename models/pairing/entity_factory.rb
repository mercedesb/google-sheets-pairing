require './models/pairing/mentor'
require './models/pairing/mentee'

class EntityFactory

  def get_entity(data)
    if (data[2].casecmp("mentor") >= 0)
      get_mentor(data[0], data[1], data[3])
    elsif (data[2].casecmp("mentee") >= 0)
      get_mentee(data[0], data[1], data[5], data[6], data[7])
    else
      raise ArgumentException.new("invalid registration type")
    end
  end


  private
  def get_mentor(name_data, email_data, preferences_data)
    Mentor.new(name_data, preferences_data.split(", "))
  end

  def get_mentee(name_data, email_data, code_link_data, feedback_type_data, preference_data)
    Mentee.new(name_data, preference_data)
  end

end