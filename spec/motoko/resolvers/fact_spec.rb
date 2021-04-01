# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Resolvers::Fact do
  subject(:column) { described_class.new('key', {}) }

  let(:node) do
    node = Motoko::Node.new('example.com', { 'key' => 'value' })
  end

  describe '#resolve_for' do
    subject { column.resolve_for(node) }

    it { is_expected.to eq('value') }
  end
end
