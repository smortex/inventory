# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Motoko::Columns::RebootRequired do
  subject(:column) { described_class.new('key', {}) }

  let(:node) do
    node = Motoko::Node.new('example.com', facts)
  end

  describe '#resolve_for' do
    subject { column.resolve_for(node) }

    {
      { 'apt_reboot_required' => false } => false,
      { 'apt_reboot_required' => true }  => true,
      { 'pkg_reboot_required' => false } => false,
      { 'pkg_reboot_required' => true }  => true,
      { 'yum_reboot_required' => false } => false,
      { 'yum_reboot_required' => true }  => true,
      {}                                 => nil,
    }.each do |k, v|
      context "with #{k.inspect}" do
        let(:facts) { k }

        it { is_expected.to eq(v) }
      end
    end
  end
end
