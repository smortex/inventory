# frozen_string_literal: true

module Motoko
  module Resolvers
    class Fact < BaseResolver
      attr_accessor :fact

      def initialize(name, options)
        @fact = options.delete('fact') || name

        super
      end

      def resolve_for(node)
        node.fact(fact)
      end
    end
  end
end
