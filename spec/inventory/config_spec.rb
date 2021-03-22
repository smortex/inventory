# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inventory::Config do
  subject(:config) { described_class.new }

  describe '#sort_by' do
    it 'has a proper default value' do
      expect(config.sort_by).to eq(%w[customer host])
    end
  end
end
