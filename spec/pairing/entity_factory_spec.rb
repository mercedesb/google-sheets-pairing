# frozen_string_literal: true

require "spec_helper"
require "pairing/entity_factory"

RSpec.describe EntityFactory, type: :model do
  subject { described_class.new }

  describe "#get_mentor" do
    it "returns an instance of mentor" do
       expect(subject.get_mentor(["r1"], ["b, c"])).to be_kind_of(Mentor)
    end
  end

  describe "#get_mentee" do
    it "returns an instance of mentee" do
       expect(subject.get_mentee(["e1"], ["b"])).to be_kind_of(Mentee)
    end
  end
end
