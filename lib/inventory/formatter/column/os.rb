# frozen_string_literal: true

module Inventory
  class Formatter
    module Column
      class Os < Base
        def resolve_for(node)
          node.fact('os.distro.description') || format('%s %s', node.fact('os.name'), node.fact('os.release.full'))
        end
      end
    end
  end
end
