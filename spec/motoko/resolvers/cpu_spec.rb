# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Resolvers::Cpu do
  subject(:column) { described_class.new('cpu', {}) }

  let(:node) do
    node = Motoko::Node.new('example.com', { 'processors' => processors })
  end

  let(:processors) do
    {
      'count'         => 8,
      'models'        => [
        'Acme(R) Foo(TM) 4200 CPU @ 42.0GHz',
        'Acme(R) Foo(TM) 4200 CPU @ 42.0GHz',
        'Acme(R) Foo(TM) 4200 CPU @ 42.0GHz',
        'Acme(R) Foo(TM) 4200 CPU @ 42.0GHz',
        'Acme(R) Foo(TM) 4200 CPU @ 42.0GHz',
        'Acme(R) Foo(TM) 4200 CPU @ 42.0GHz',
        'Acme(R) Foo(TM) 4200 CPU @ 42.0GHz',
        'Acme(R) Foo(TM) 4200 CPU @ 42.0GHz',
      ],
      'physicalcount' => 1,
      'speed'         => '42.0 GHz',
    }
  end

  describe '#resolve_for' do
    subject { column.resolve_for(node) }

    it { is_expected.to eq(' 8 × Acme Foo 4200 CPU @ 42.0GHz') }
  end
end
