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

# expected:
# s1 : p1
# s1 : p2
# s1 : p3
# s2 : p4
# s3 : p1

  subject { described_class.new(mentors, mentees) }
  # describe "#build" do
  #   it "creates a graph with the expected shape" do
  #     graph = subject.build
  #     expect(graph.nodes.length).to eq(9)
  #     expect(graph.edges.length).to eq(12)
  #     expect(graph["s1"].edges.length).to eq(3)
  #     expect(graph["s2"].edges.length).to eq(1)
  #     expect(graph["s3"].edges.length).to eq(1)
  #   end
  # end
  

  # expected: 
  # [1 1 1 0]
  # [0 0 0 1]
  # [1 0 0 0]


  # describe "#build" do
  #   it "creates a graph with the expected shape" do
  #     graph = subject.build
  #     expect(graph.length).to eq(3)
  #     expect(graph[0].length).to eq(4)
  #     expect(graph[0]).to eq([1, 1, 1, 0])
  #     expect(graph[1]).to eq([0, 0, 0, 1])
  #     expect(graph[2]).to eq([1, 0, 0, 0])
  #   end
  # end

  describe "#build" do
    it "creates a graph with the expected shape" do
      graph = subject.build
      expect(graph.length).to eq(3)
      expect(graph["s1"].length).to eq(4)
      expect(graph["s1"].edges).to eq([1, 1, 1, 0])
      expect(graph["s2"].edges).to eq([0, 0, 0, 1])
      expect(graph["s3"].edges).to eq([1, 0, 0, 0])
    end
  end
end
