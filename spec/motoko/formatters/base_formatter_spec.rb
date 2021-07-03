# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Formatters::BaseFormatter do
  describe '#format' do
    subject { described_class.new.format(value) }

    {
      nil   => '',
      true  => 'true',
      false => 'false',
      42    => '42',
      'foo' => 'foo',
    }.each do |k, v|
      context "with #{k.inspect}" do
        let(:value) { k }

        it { is_expected.to eq(v) }
      end
    end

    context 'with an Array' do
      let(:value) { %w[a b c] }

      it { is_expected.to eq("a\nb\nc") }
    end

    context 'with a Hash' do
      let(:value) { { 'a' => 1, 'b' => 2, 'c' => 3 } }

      it { is_expected.to eq("a\nb\nc") }
    end
  end
end
