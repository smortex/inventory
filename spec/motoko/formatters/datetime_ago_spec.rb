# frozen_string_literal: true

require 'spec_helper'

require 'timecop'

RSpec.describe Motoko::Formatters::DatetimeAgo do
  before do
    Timecop.freeze(Time.utc(2021, 5, 1, 0, 0, 0))
  end

  after do
    Timecop.return
  end

  describe '#format' do
    subject(:formatter) { described_class.new.format(value) }

    {
      '2021-04-30 23:59:59' => ' 1s',
      '2021-04-30 23:59:00' => ' 1m  0s',
      '2021-04-30 23:00:00' => ' 1h  0m  0s',
      '2021-04-30 00:00:00' => '1d  0h  0m  0s',
      '2021-03-19 22:20:30' => '42d  1h 39m 30s',
    }.each do |k, v|
      context "with #{k.inspect}" do
        let(:value) { k }

        it { is_expected.to eq(v) }
      end
    end
  end
end
