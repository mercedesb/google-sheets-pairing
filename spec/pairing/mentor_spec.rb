# frozen_string_literal: true

require "spec_helper"
require "pairing/mentor"

RSpec.describe Mentor, type: :model do
  subject { described_class.new("r1", "email", ["b", "c"]) }

  describe "#attrs" do
    it "reads attrs" do
       expect(subject.respond_to?(:name)).to eq true
       expect(subject.respond_to?(:preferences)).to eq true
    end
  end
end
