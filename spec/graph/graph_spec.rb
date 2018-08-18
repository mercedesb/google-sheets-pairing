# frozen_string_literal: true

require "spec_helper"

RSpec.describe Graph, type: :model do
  subject { described_class.new }

  describe "#attrs" do
    it "reads attrs" do
      expect(subject.respond_to?(:nodes)).to eq true
    end
  end

  describe "#add_node" do
    it "adds an node to nodes hash" do
      new_node = Node.new(OpenStruct.new(:name => "new"))
      current_length = subject.length

      subject.add_node(new_node)
      expect(subject.length).to eq(current_length+1)
      expect(subject["new"]).to eq(new_node)
    end
  end

  describe "#nodes" do
    it "returns a hash" do
      expect(subject.nodes).to eq({})
    end
  end

  describe "#length" do
    it "returns the length of the node hash" do
      expect(subject.length).to eq 0
    end
  end
end
