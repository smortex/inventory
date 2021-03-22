# frozen_string_literal: true

require 'spec_helper'

require 'timecop'

RSpec.describe Inventory::Formatter::Column::Formatters::TimestampAgo do
  subject(:formatter) { described_class.new }

  before do
    Timecop.freeze(Time.at(1616349857))
  end

  after do
    Timecop.return
  end

  describe '#format' do
    it 'count seconds correctly' do
      expect(formatter.format('1616349856')).to eq('1s')
    end

    it 'count minutes correctly' do
      expect(formatter.format('1616349797')).to eq('1m 0s')
    end

    it 'count hours correctly' do
      expect(formatter.format('1616346257')).to eq('1h 0m 0s')
    end

    it 'count days correctly' do
      expect(formatter.format('1616263457')).to eq('1d 0h 0m 0s')
    end

    it 'behaves correctly' do
      expect(formatter.format('1612715087')).to eq('42d 1h 39m 30s')
    end
  end
end
