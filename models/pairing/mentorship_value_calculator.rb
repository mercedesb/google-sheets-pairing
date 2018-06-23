class MentorshipValueCalculator
  def get_value(mentor, mentee)
    mentor.preferences.include?(mentee.preference) ? 1 : 0
  end
end