# frozen_string_literal: true

module Motoko
  module Resolvers
    class Os < BaseResolver
      def resolve_for(node)
        node.fact('os.distro.description') || format('%<name>s %<release>s', name: node.fact('os.name'), release: node.fact('os.release.full'))
      end
    end
  end
end
