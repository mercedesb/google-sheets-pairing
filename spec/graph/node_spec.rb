# frozen_string_literal: true

require "spec_helper"

RSpec.describe Node, type: :model do
  let(:name) { "r1" }

  subject { described_class.new(name) }

  describe "#attrs" do
    it "reads attrs" do
      expect(subject.respond_to?(:name)).to eq true
    end
  end

  describe "#add_edge" do
    it "adds an edge to edges array" do
      new_node = Node.new("new")
      current_length = subject.length

      subject.add_edge(new_node, 0)
      expect(subject.length).to eq(current_length+1)
    end
  end

  describe "#edges" do
    it "returns an array" do
      expect(subject.edges).to eq([])
    end
  end

  describe "#length" do
    it "returns the length of the edge array" do
      expect(subject.length).to eq 0
    end
  end
end
