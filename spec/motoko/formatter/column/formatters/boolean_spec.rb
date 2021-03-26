# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Formatter::Column::Formatters::Boolean do
  subject(:formatter) { described_class.new }

  describe '#format' do
    it 'returns nil when given false' do
      expect(formatter.format(false)).to be_nil
    end

    it 'returns nil when given nil' do
      expect(formatter.format(nil)).to be_nil
    end

    it 'returns a checkmark when given an empty string' do
      expect(formatter.format('')).to eq('√')
    end

    it 'returns a checkmark when given a string' do
      expect(formatter.format('foo')).to eq('√')
    end

    it 'returns a checkmark when given a number' do
      expect(formatter.format(42)).to eq('√')
    end

    it 'returns a checkmark when given trye' do
      expect(formatter.format(true)).to eq('√')
    end
  end
end
