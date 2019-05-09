# frozen_string_literal: true

require 'spec_helper'
require 'pairing/entity_factory'

RSpec.describe EntityFactory, type: :model do
  subject { described_class.new }

  describe '#get_entity' do
    describe 'when registration type is mentor' do
      it 'returns an instance of mentor' do
        expect(subject.get_entity(['r1', 'email', 'mentor', 'b, c'])).to be_kind_of(Mentor)
      end
    end

    describe 'when registration type is mentee' do
      it 'returns an instance of mentee' do
        expect(subject.get_entity(['e1', 'email', 'mentee', '', '', 'code', 'feedback', 'b'])).to be_kind_of(Mentee)
      end
    end
  end
end
