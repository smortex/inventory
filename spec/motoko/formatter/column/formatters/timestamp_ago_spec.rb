# frozen_string_literal: true

require 'spec_helper'

require 'timecop'

RSpec.describe Motoko::Formatter::Column::Formatters::TimestampAgo do
  before do
    Timecop.freeze(Time.at(1616349857))
  end

  after do
    Timecop.return
  end

  describe '#format' do
    subject(:formatter) { described_class.new.format(value) }

    {
      '1616349856' => ' 1s',
      '1616349797' => ' 1m  0s',
      '1616346257' => ' 1h  0m  0s',
      '1616263457' => '1d  0h  0m  0s',
      '1612715087' => '42d  1h 39m 30s',
    }.each do |k, v|
      context "with #{k.inspect}" do
        let(:value) { k }

        it { is_expected.to eq(v) }
      end
    end
  end
end
