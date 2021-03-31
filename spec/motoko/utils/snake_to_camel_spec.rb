# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Utils::SnakeToCamel do
  describe '#snake_to_camel_case' do
    subject do
      dummy_instance.snake_to_camel_case(input)
    end

    let!(:dummy_instance) do
      dummy_instance = Class.new
      dummy_instance.extend(described_class)
      dummy_instance
    end

    {
      'foo'         => 'Foo',
      'foo_bar'     => 'FooBar',
      'foo_bar_baz' => 'FooBarBaz'
    }.each do |k, v|
      context "with input '#{k}'" do
        let(:input) { k }

        it { is_expected.to eq(v) }
      end
    end
  end
end
