# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Formatter::Column::Formatters::Ellipsis do
  describe '#format' do
    subject { formatter.format(value) }

    let(:formatter) { described_class.new }

    {
      'I am a very long string, more than 20 chars!' => 'I am a very long st…',
      'foo'                                          => 'foo',
      nil                                            => nil,
    }.each do |k, v|
      context "with #{k.inspect}" do
        let(:value) { k }

        it { is_expected.to eq(v) }
      end
    end

    context 'with max_length = 5' do
      before do
        formatter.max_length = 5
      end

      {
        'I am a very long string, more than 20 chars!' => 'I am…',
        '12345'                                        => '12345',
        '123456'                                       => '1234…',
      }.each do |k, v|
        context "with #{k.inspect}" do
          let(:value) { k }

          it { is_expected.to eq(v) }
        end
      end
    end
  end
end
