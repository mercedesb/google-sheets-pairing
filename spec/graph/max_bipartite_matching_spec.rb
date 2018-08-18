# frozen_string_literal: true

require "spec_helper"
require "graph/max_bipartite_matching"
require "graph/graph_builder"
require "pairing/mentor"
require "pairing/mentee"
require "pairing/mentorship_value_calculator"

RSpec.describe MaxBipartiteMatching, type: :model do
  let(:mentors) { [
      Mentor.new("Keanan K", "email", ["Javascript (vanilla js)", "jQuery", "Python", "HTML", "CSS", "SASS/SCSS", "PHP", "WordPress"]),
      Mentor.new("Mat B", "email", ["Javascript (vanilla js)", "Vue", "jQuery", "Ember", "Node", "HTML", "CSS", "SASS/SCSS"]),
      Mentor.new("Dan R", "email", ["Javascript (vanilla js)", "React", "jQuery", "Koa", "Dojo", "Node", "Java", "Spring", "HTML", "CSS", "SASS/SCSS"]),
      Mentor.new("Jarod K", "email", ["Javascript (vanilla js)", "jQuery", "Java", "HTML", "CSS", "ColdFusion"]),
      Mentor.new("Dennis L", "email", ["Javascript (vanilla js)", "Vue", "Java", "Spring", "HTML", "CSS"]),
      Mentor.new("Maria S", "email", ["Javascript (vanilla js)", "jQuery", "Ruby", "Java", "Python", "HTML", "CSS", "Perl", "SQL"]),
      Mentor.new("Shweta K", "email", ["Java", "Python", "SQL", "C++"]),
      Mentor.new("Eryan C", "email", ["Javascript (vanilla js)", "React", "jQuery", "Ruby", "Ruby on Rails", "HTML", "CSS", "SASS/SCSS"]),
      Mentor.new("Aji S", "email", ["Javascript (vanilla js)", "React", "jQuery", "Ruby", "Ruby on Rails", "HTML", "CSS", "SASS/SCSS", "Shell"])
    ] }
  let(:mentees) { [
      Mentee.new("A", "email", "code", "feedback", "React"),
      Mentee.new("B", "email", "code", "feedback", "Vue"),
      Mentee.new("C", "email", "code", "feedback", "React"),
      Mentee.new("D", "email", "code", "feedback", "Ruby"),
      Mentee.new("E", "email", "code", "feedback", "Java"),
      Mentee.new("F", "email", "code", "feedback", "Python"),
      Mentee.new("G", "email", "code", "feedback", "React"),
      Mentee.new("H", "email", "code", "feedback", "React"),
      Mentee.new("I", "email", "code", "feedback", "React")
    ] }

  let(:graph) { GraphBuilder.new.build(mentors, mentees, MentorshipValueCalculator.new) }
  subject { described_class.new }


  describe "#match" do
    it "returns the max number of matches" do
      expect(subject.match(graph).matches.length).to eq(7)
    end
  end
end
