# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Formatter::Column::Formatters::Timestamp do
  before do
    ENV['TZ'] = 'Pacific/Tahiti'
  end

  after do
    ENV.delete('TZ')
  end

  describe '#format' do
    subject(:formatter) { described_class.new.format(value) }

    {
      '1616349857' => '2021-03-21 08:04:17 -1000',
    }.each do |k, v|
      context "with #{k.inspect}" do
        let(:value) { k }

        it { is_expected.to eq(v) }
      end
    end
  end
end
