# frozen_string_literal: true

require "spec_helper"
require "graph/max_bipartite_matching"

RSpec.describe MaxBipartiteMatching, type: :model do
  let(:graph) { [[0, 1, 1, 0, 0, 0],
          [1, 0, 0, 1, 0, 0],
          [0, 0, 1, 0, 0, 0],
          [0, 0, 1, 1, 0, 0],
          [0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 1]] }

  subject { described_class.new(graph) }


  describe "#maximum_bipartite_matching" do
    it "returns the max number of matches" do
      expect(subject.maximum_bipartite_matching).to eq(5)
    end
  end
end
