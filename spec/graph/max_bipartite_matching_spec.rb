# frozen_string_literal: true

require "spec_helper"
require "graph/max_bipartite_matching"
require "graph/graph_builder"
require "pairing/mentor"
require "pairing/mentee"
require "pairing/mentorship_value_calculator"

RSpec.describe MaxBipartiteMatching, type: :model do
  let(:mentors) { [
      Mentor.new("Keanan Koppenhaver", ["Javascript (vanilla js)", "jQuery", "Python", "HTML", "CSS", "SASS/SCSS", "PHP", "WordPress"]),
      Mentor.new("Mat Biscan", ["Javascript (vanilla js)", "Vue", "jQuery", "Ember", "Node", "HTML", "CSS", "SASS/SCSS"]),
      Mentor.new("Dan Rumney", ["Javascript (vanilla js)", "React", "jQuery", "Koa", "Dojo", "Node", "Java", "Spring", "HTML", "CSS", "SASS/SCSS"]),
      Mentor.new("Jarod Knoten", ["Javascript (vanilla js)", "jQuery", "Java", "HTML", "CSS", "ColdFusion"]),
      Mentor.new("Dennis Levin", ["Javascript (vanilla js)", "Vue", "Java", "Spring", "HTML", "CSS"]),
      Mentor.new("Maria Saenz", ["Javascript (vanilla js)", "jQuery", "Ruby", "Java", "Python", "HTML", "CSS", "Perl", "SQL"]),
      Mentor.new("Shweta Kapur", ["Java", "Python", "SQL", "C++"]),
      Mentor.new("Eryan Cobham", ["Javascript (vanilla js)", "React", "jQuery", "Ruby", "Ruby on Rails", "HTML", "CSS", "SASS/SCSS"]),
      Mentor.new("Aji Slater", ["Javascript (vanilla js)", "React", "jQuery", "Ruby", "Ruby on Rails", "HTML", "CSS", "SASS/SCSS", "Shell"])
    ] }
  let(:mentees) { [
      Mentee.new("A", "React"),
      Mentee.new("B", "Vue"),
      Mentee.new("C", "React"),
      Mentee.new("D", "Ruby"),
      Mentee.new("E", "Java"),
      Mentee.new("F", "Python"),
      Mentee.new("G", "React"),
      Mentee.new("H", "React"),
      Mentee.new("I", "React")
    ] }

  let(:graph) { GraphBuilder.new.build(mentors, mentees, MentorshipValueCalculator.new) }
  subject { described_class.new }


  describe "#match" do
    it "returns the max number of matches" do
      expect(subject.match(graph).matches.length).to eq(7)
    end
  end
end
