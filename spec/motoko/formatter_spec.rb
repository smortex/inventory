# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Formatter do
  subject(:formater) { described_class.new }

  before do
    formater.columns = ['value2']
    formater.mono = true
    formater.nodes = [
      Motoko::Node.new('node1', 'value1' => 'foo', 'value2' => 'a'),
      Motoko::Node.new('node2', 'value1' => 'foo', 'value2' => ['b', 'c']),
    ]
  end

  describe '#data' do
    subject { formater.data }

    it { is_expected.to eq([['a'], ["b\nc"]]) }
  end

  describe '#headings' do
    subject { formater.headings }

    it { is_expected.to eq([{ alignment: :center, value: 'Value2' }]) }

    context 'when counting values' do
      before do
        formater.count = true
      end

      it { is_expected.to eq([{ alignment: :center, value: 'Value2 (2)' }]) }
    end
  end

  describe '#sort_by' do
    subject { formater.sort_by }

    it { is_expected.to eq(%w[customer host]) }
  end

  describe '#sorted_nodes' do
    subject { formater.sorted_nodes }

    let(:n1) { Motoko::Node.new('node1', 'value1' => 'foo', 'value2' => 'a') }
    let(:n2) { Motoko::Node.new('node2', 'value1' => 'foo', 'value2' => 'b') }
    let(:n3) { Motoko::Node.new('node3', 'value1' => 'bar', 'value2' => 'c') }

    before do
      formater.nodes = [
        n1,
        n2,
        n3,
      ]
      formater.sort_by = ['value1', 'host']
    end


    it { is_expected.to eq([n3, n1, n2]) }
  end
end
