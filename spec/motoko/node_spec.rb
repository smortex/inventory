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

    {
      'osfamily'                                    => 'FreeBSD',
      'os.family'                                   => 'FreeBSD',
      'netwoking.interfaces.lo0.bindings.0.address' => '127.0.0.1',
    }.each do |k, v|
      context "with existing fact '#{k}'" do
        let(:fact) { k }

        it { is_expected.to eq(v) }
      end
    end

    [
      'foo',
      'foo.bar.baz',
      'netwoking.interfaces.lo0.bindings.1.address',
    ].each do |k|
      context "with non existing fact '#{k}'" do
        let(:fact) { k }

        it { is_expected.to be_nil }
      end
    end
  end
end
