# frozen_string_literal: true

module Motoko
  class Node
    attr_reader :identity

    def initialize(identity, facts)
      @identity = identity
      @facts    = facts
    end

    def fact(name)
      result = @facts
      components = name.to_s.split('.')
      while (component = components.shift)
        case result
        when Hash
          result = result[component]
        when Array
          result = result[Integer(component)]
        when NilClass
          return nil
        end
      end
      result
    end

    class Choria < Motoko::Node
      def initialize(node)
        super(node[:sender], node[:data][:facts])
      end
    end
  end
end
