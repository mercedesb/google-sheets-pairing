# frozen_string_literal: true

class Mentor
  attr_reader :name, :email, :preferences

  def initialize(name, email, preferences)
    @name = name
    @email = email
    @preferences = preferences
  end

  def to_s
    "#{name}, #{email}"
  end

  def spreadsheet_data
    [name, email]
  end
end
