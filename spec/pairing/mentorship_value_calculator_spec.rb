# frozen_string_literal: true

require 'spec_helper'
require 'pairing/mentorship_value_calculator'

RSpec.describe MentorshipValueCalculator, type: :model do
  let(:mentor) { Mentor.new('r1', 'email', %w[b c]) }
  subject { described_class.new }

  describe '#get_value' do
    let(:mentee) { Mentee.new('e1', 'email', 'code', 'feedback', 'a') }
    context 'when mentor and mentee do not share a preference' do
      it 'returns 0' do
        expect(subject.get_value(mentor, mentee)).to eq 0
      end
    end

    context 'when mentor and mentee share a preference' do
      let(:mentee) { Mentee.new('e1', 'email', 'code', 'feedback', 'b') }
      it 'returns 1' do
        expect(subject.get_value(mentor, mentee)).to eq 1
      end
    end
  end
end
