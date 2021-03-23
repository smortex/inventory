# frozen_string_literal: true

module Inventory
  class Formatter
    module Column
      class RebootRequired < Base
        def resolve_for(node)
          node.fact('apt_reboot_required') || node.fact('yum_reboot_required') || node.fact('pkg_reboot_required')
        end
      end
    end
  end
end
