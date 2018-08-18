# frozen_string_literal: true

require "spec_helper"
require "pairing/mentee"

RSpec.describe Mentee, type: :model do
  subject { described_class.new("e1", "email", "code", "feedback", "c") }

  describe "#attrs" do
    it "reads attrs" do
       expect(subject.respond_to?(:name)).to eq true
       expect(subject.respond_to?(:preference)).to eq true
    end
  end
end
