# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Utils::TimeAgo do
  describe '#seconds_to_human' do
    subject do
      dummy_instance.seconds_to_human(input)
    end

    let!(:dummy_instance) do
      dummy_instance = Class.new
      dummy_instance.extend(described_class)
      dummy_instance
    end

    {
      0      => ' 0s',
      60     => ' 1m  0s',
      3600   => ' 1h  0m  0s',
      86400  => '1d  0h  0m  0s',
      406332 => '4d 16h 52m 12s',

    }.each do |k, v|
      context "with input '#{k}'" do
        let(:input) { k }

        it { is_expected.to eq(v) }
      end
    end
  end
end
