# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::OptionParser do
  describe '::add_shortcut_options' do
    let(:parser) { double }
    let(:formatter) { Motoko::Formatter.new }
    let(:local_options) { {} }
    let(:columns) { ['foo'] }

    before do
      allow(parser).to receive(:separator)
      allow(parser).to receive(:on).and_yield
      allow(formatter).to receive_messages(shortcuts: shortcuts, columns: columns)
      described_class.add_shortcut_options(parser, formatter, local_options)
    end

    context 'with add_columns' do
      let(:shortcuts) do
        { 'test' => { 'description' => 'Unit test', 'add_columns' => %w[bar baz] } }
      end

      it do
        expect(parser).to have_received(:on).with('--test', 'Unit test')
      end

      it do
        expect(formatter.columns).to eq(%w[foo bar baz])
      end
    end

    context 'with columns' do
      let(:shortcuts) do
        { 'test' => { 'description' => 'Unit test', 'columns' => %w[bar baz] } }
      end

      it do
        expect(parser).to have_received(:on).with('--test', 'Unit test')
      end

      it do
        expect(formatter.columns).to eq(%w[bar baz])
      end
    end
  end
end
