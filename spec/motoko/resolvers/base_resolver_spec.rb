# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Resolvers::BaseResolver do
  subject(:column) { described_class.new(column_name, column_spec) }

  let(:column_name) { 'foo' }
  let(:column_spec) { {} }

  describe '#align' do
    subject { column.align }

    it { is_expected.to be_nil }
  end

  describe '#human_name' do
    subject { column.human_name }

    it { is_expected.to eq('Foo') }
  end
end
