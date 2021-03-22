# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inventory::Formatter::Column::Formatters::Timestamp do
  subject(:formatter) { described_class.new }

  before do
    ENV['TZ'] = 'Pacific/Tahiti'
  end

  after do
    ENV.delete('TZ')
  end

  describe '#format' do
    it 'returns the time in the local zone' do
      expect(formatter.format('1616349857')).to eq('2021-03-21 08:04:17 -1000')
    end
  end
end
