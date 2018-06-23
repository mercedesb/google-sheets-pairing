# frozen_string_literal: true

require "spec_helper"
require "mentor"
require "mentee"
require "graph/graph_builder"

RSpec.describe GraphBuilder, type: :model do
  let(:mentors) { [
      Mentor.new("s1", ["a", "b"]),
      Mentor.new("s2", ["c"]),
      Mentor.new("s3", ["a", "d"])
    ] }
  let(:mentees) { [
      Mentee.new("p1", "a"),
      Mentee.new("p2", "b"),
      Mentee.new("p3", "b"),
      Mentee.new("p4", "c")
    ] }

  subject { described_class.new(mentors, mentees) }
  
  # expected: 
  # [1 1 1 0]
  # [0 0 0 1]
  # [1 0 0 0]

  describe "#build" do
    it "creates a graph with the expected shape" do
      graph = subject.build
      expect(graph.length).to eq(3)
      expect(graph["s1"].length).to eq(4)
      expect(graph["s1"].edges.map {|edge| edge.value}).to eq([1, 1, 1, 0])
      expect(graph["s2"].edges.map {|edge| edge.value}).to eq([0, 0, 0, 1])
      expect(graph["s3"].edges.map {|edge| edge.value}).to eq([1, 0, 0, 0])
    end
  end
end
