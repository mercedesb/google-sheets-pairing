# frozen_string_literal: true

require "spec_helper"
require "graph/max_bipartite_matching"
require "graph/graph_builder"
require "mentor"
require "mentee"

RSpec.describe MaxBipartiteMatching, type: :model do
  let(:mentors) { [
      Mentor.new("r1", ["b"]),
      Mentor.new("r2", ["a", "c"]),
      Mentor.new("r3", ["b"]),
      Mentor.new("r4", ["b", "c"]),
      Mentor.new("r5", ["f", "g", "h"]),
      Mentor.new("r6", ["e", "f"])
    ] }
  let(:mentees) { [
      Mentee.new("e1", "a"),
      Mentee.new("e2", "b"),
      Mentee.new("e3", "b"),
      Mentee.new("e4", "c"),
      Mentee.new("e5", "d"),
      Mentee.new("e6", "e")
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
