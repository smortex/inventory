# frozen_string_literal: true

module Motoko
  module Resolvers
    class Identity < BaseResolver
      def resolve_for(node)
        node.identity
      end
    end
  end
end
