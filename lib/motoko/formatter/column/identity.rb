# frozen_string_literal: true

module Motoko
  class Formatter
    module Column
      class Identity < Base
        def resolve_for(node)
          node.identity
        end
      end
    end
  end
end
