# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Utils::PuppetDB do
  describe '::class_filter' do
    subject do
      described_class.class_filter(klass)
    end

    {
      'foo'           => "certname in resources[certname] { type = 'Class' and title = 'Foo' }",
      'foo::bar::baz' => "certname in resources[certname] { type = 'Class' and title = 'Foo::Bar::Baz' }",
      '/foo::bar/'    => "certname in resources[certname] { type = 'Class' and title ~ 'Foo::Bar' }",
    }.each do |k, v|
      context "with class '#{k}'" do
        let(:klass) { k }

        it { is_expected.to eq(v) }
      end
    end
  end

  describe '::fact_filter' do
    subject do
      described_class.fact_filter(fact)
    end

    {
      'foo=bar'     => "certname in inventory[certname] { facts.foo = 'bar' }",
      'foo.bar=baz' => "certname in inventory[certname] { facts.foo.bar = 'baz' }",
      'foo!=bar'    => "certname in inventory[certname] { facts.foo != 'bar' }",
      'foo=/bar/'   => "certname in inventory[certname] { facts.foo ~ 'bar' }",
      'foo<42'      => 'certname in inventory[certname] { facts.foo < 42 }',
      'foo<=42'     => 'certname in inventory[certname] { facts.foo <= 42 }',
      'foo>42'      => 'certname in inventory[certname] { facts.foo > 42 }',
      'foo>=42'     => 'certname in inventory[certname] { facts.foo >= 42 }',
    }.each do |k, v|
      context "with fact '#{k}'" do
        let(:fact) { k }

        it { is_expected.to eq(v) }
      end
    end
  end

  describe '::identity_filter' do
    subject do
      described_class.identity_filter(identity)
    end

    {
      'foo'   => "certname = 'foo'",
      '/foo/' => "certname ~ 'foo'",
    }.each do |k, v|
      context "with identity '#{k}'" do
        let(:identity) { k }

        it { is_expected.to eq(v) }
      end
    end
  end
end
