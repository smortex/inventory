# frozen_string_literal: true

module Motoko
  module Columns
    class Identity < BaseColumn
      def resolve_for(node)
        node.identity
      end
    end
  end
end
