# frozen_string_literal: true

require "spec_helper"
require "graph/edge"

RSpec.describe Edge, type: :model do
  let(:head_name) { "r1" }
  let(:tail) { Node.new("e1") }
  let(:value) { 0 }

  subject { described_class.new(head_name, tail, value) }

  describe "#attrs" do
    it "reads attrs" do
       expect(subject.respond_to?(:head_name)).to eq true
       expect(subject.respond_to?(:tail)).to eq true
       expect(subject.respond_to?(:value)).to eq true
       expect(subject.respond_to?(:visited)).to eq true
       
    end

    it "writes attrs" do
      expect(subject.respond_to?(:visited=)).to eq true
    end
  end
end
