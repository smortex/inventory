# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Resolvers::Os do
  subject(:column) { described_class.new('os', {}) }

  let(:node) do
    Motoko::Node.new('example.com', facts)
  end

  describe '#resolve_for' do
    subject { column.resolve_for(node) }

    context 'with distro description' do
      let(:facts) do
        { 'os' => { 'distro' => { 'description' => 'Acme 42.0' } } }
      end

      it { is_expected.to eq('Acme 42.0') }
    end

    context 'with os generic info' do
      let(:facts) do
        { 'os' => { 'name' => 'Acme', 'release' => { 'full' => '42.0' } } }
      end

      it { is_expected.to eq('Acme 42.0') }
    end
  end
end
