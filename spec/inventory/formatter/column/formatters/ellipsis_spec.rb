# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inventory::Formatter::Column::Formatters::Ellipsis do
  subject(:formatter) { described_class.new }

  describe '#format' do
    it 'ellipsis a long string' do
      expect(formatter.format('I am a very long string, more than 20 chars!')).to eq('I am a very long st…')
    end

    it 'preserve a short string' do
      expect(formatter.format('foo')).to eq('foo')
    end

    it 'preserve a string with max_length length' do
      formatter.max_length = 5
      expect(formatter.format('12345')).to eq('12345')
    end

    it 'returns nil when given nil' do
      expect(formatter.format(nil)).to be_nil
    end
  end
end
