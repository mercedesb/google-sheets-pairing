class Mentee
  attr_reader :name, :email, :code_link, :feedback_type, :preference

  def initialize(name, email, code_link, feedback_type, preference)
    @name = name
    @email = email
    @code_link = code_link
    @feedback_type = feedback_type
    @preference = preference
  end

  def to_s
    "#{name}, #{email}, #{code_link}, #{feedback_type}, #{preference}"
  end
end