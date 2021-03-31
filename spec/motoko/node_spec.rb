# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Node do
  subject(:node) do
    described_class.new('example.com', YAML.safe_load(<<~YAML))
      ---
      netwoking:
        interfaces:
          lo0:
            bindings:
              - address: "127.0.0.1"
                netmask: "255.0.0.0"
                network: "127.0.0.0"
      osfamily: "FreeBSD"
      os:
        family: "FreeBSD"
    YAML
  end

  describe '#fact' do
    subject do
      node.fact(fact)
    end

    context 'with an existing fact' do
      let(:fact) { 'osfamily' }

      it { is_expected.to eq('FreeBSD') }
    end

    context 'with an existing dotted notation fact' do
      let(:fact) { 'os.family' }

      it { is_expected.to eq('FreeBSD') }
    end

    context 'with a non-existing fact' do
      let(:fact) { 'foo' }

      it { is_expected.to be_nil }
    end

    context 'with a non-existing dotted notation fact' do
      let(:fact) { 'foo.bar.baz' }

      it { is_expected.to be_nil }
    end

    context 'when traversing an array' do
      context 'with an existing dotted notation fact' do
        let(:fact) { 'netwoking.interfaces.lo0.bindings.0.address' }

        it { is_expected.to eq('127.0.0.1') }
      end

      context 'with a non-existing dotted notation fact' do
        let(:fact) { 'netwoking.interfaces.lo0.bindings.1.address' }

        it { is_expected.to be_nil }
      end
    end
  end
end
