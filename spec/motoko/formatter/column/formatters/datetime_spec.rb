# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Formatter::Column::Formatters::Datetime do
  subject(:formatter) { described_class.new }

  before do
    ENV['TZ'] = 'Pacific/Tahiti'
  end

  after do
    ENV.delete('TZ')
  end

  describe '#format' do
    it 'returns the time in the local zone' do
      expect(formatter.format('2021-03-12 18:23:13 +0100')).to eq('2021-03-12 07:23:13 -1000')
    end
  end
end
