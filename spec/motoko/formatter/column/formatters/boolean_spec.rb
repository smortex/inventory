# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Formatter::Column::Formatters::Boolean do
  describe '#format' do
    subject { described_class.new.format(value) }

    [
      false,
      nil,
    ].each do |k|
      context "with #{k.inspect}" do
        let(:value) { k }

        it { is_expected.to be_nil }
      end
    end

    [
      true,
      '',
      'foo',
      42,
    ].each do |k|
      context "with #{k.inspect}" do
        let(:value) { k }

        it { is_expected.to eq('√') }
      end
    end
  end
end
