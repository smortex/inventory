# frozen_string_literal: true

module Motoko
  module Resolvers
    class Os < BaseResolver
      def resolve_for(node)
        node.fact('os.distro.description') || format('%s %s', node.fact('os.name'), node.fact('os.release.full'))
      end
    end
  end
end
