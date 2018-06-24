require './models/pairing/entity_factory'

module DevTogetherMatching
  MENTOR_ID_RANGE = "C2:C50"
  MENTOR_PREFERENCES_RANGE = "D2:D50"
  MENTEE_ID_RANGE = "C2:C50"
  MENTEE_PREFERENCE_RANGE = "D2:D50"

  def self.entity_factory
    @entity_factory ||= EntityFactory.new
  end

  def self.get_mentors(name_data, preferences_data)
    mentors = []
    name_data.values.each_with_index do |name, index|
      mentors << entity_factory.get_mentor(name, preferences_data.values[index])
    end
    mentors
  end

  def self.get_mentees(name_data, preference_data)
    mentees = []
    name_data.values.each_with_index do |name, index|
      mentees << entity_factory.get_mentee(name, preference_data.values[index])
    end
    mentees
  end

end