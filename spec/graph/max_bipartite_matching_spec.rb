# frozen_string_literal: true

require "spec_helper"
require "graph/max_bipartite_matching"
require "graph/graph_builder"
require "mentor"
require "mentee"

RSpec.describe MaxBipartiteMatching, type: :model do
  let(:mentors) { [
      Mentor.new("r1", ["b", "c"]),
      Mentor.new("r2", ["a", "d"]),
      Mentor.new("r3", ["c"]),
      Mentor.new("r4", ["c", "d"]),
      Mentor.new("r5", ["g", "h"]),
      Mentor.new("r6", ["f"])
    ] }
  let(:mentees) { [
      Mentee.new("e1", "a"),
      Mentee.new("e2", "b"),
      Mentee.new("e3", "c"),
      Mentee.new("e4", "d"),
      Mentee.new("e5", "e"),
      Mentee.new("e6", "f")
    ] }

  # let(:graph) { [[0, 1, 1, 0, 0, 0],
  #         [1, 0, 0, 1, 0, 0],
  #         [0, 0, 1, 0, 0, 0],
  #         [0, 0, 1, 1, 0, 0],
  #         [0, 0, 0, 0, 0, 0],
  #         [0, 0, 0, 0, 0, 1]] }

  let(:graph) { GraphBuilder.new(mentors, mentees).build }
  subject { described_class.new(graph) }


  describe "#maximum_bipartite_matching" do
    it "returns the max number of matches" do
      expect(subject.maximum_bipartite_matching).to eq(5)
    end
  end
end
