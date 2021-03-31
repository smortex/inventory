# frozen_string_literal: true

module Motoko
  module Columns
    class RebootRequired < BaseColumn
      def resolve_for(node)
        node.fact('apt_reboot_required') || node.fact('yum_reboot_required') || node.fact('pkg_reboot_required')
      end
    end
  end
end
