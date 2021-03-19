# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inventory::Node do
  subject(:node) do
    Inventory::Node.new({
                          sender: 'example.com',
                          data: {
                            facts: {
                              'osfamily' => 'FreeBSD',
                              'os' => {
                                'family' => 'FreeBSD',
                              }
                            },
                            classes: [],
                            agents: [],
                          }
                        })
  end

  context '#fact' do
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
  end
end
