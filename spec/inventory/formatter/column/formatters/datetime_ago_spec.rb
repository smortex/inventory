# frozen_string_literal: true

require 'spec_helper'

require 'timecop'

RSpec.describe Inventory::Formatter::Column::Formatters::DatetimeAgo do
  subject(:formatter) { described_class.new }

  before do
    Timecop.freeze(Time.utc(2021, 5, 1, 0, 0, 0))
  end

  after do
    Timecop.return
  end

  describe '#format' do
    it 'counts seconds correctly' do
      expect(formatter.format('2021-04-30 23:59:59')).to eq(' 1s')
    end

    it 'counts minutes correctly' do
      expect(formatter.format('2021-04-30 23:59:00')).to eq(' 1m  0s')
    end

    it 'counts hours correctly' do
      expect(formatter.format('2021-04-30 23:00:00')).to eq(' 1h  0m  0s')
    end

    it 'counts days correctly' do
      expect(formatter.format('2021-04-30 00:00:00')).to eq('1d  0h  0m  0s')
    end

    it 'behaves correctly' do
      expect(formatter.format('2021-03-19 22:20:30')).to eq('42d  1h 39m 30s')
    end
  end
end
