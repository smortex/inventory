# frozen_string_literal: true

module Motoko
  class Node
    attr_reader :identity, :classes, :agents

    def initialize(resp)
      @identity = resp[:sender]
      @facts    = resp[:data][:facts]
      @classes  = resp[:data][:classes]
      @agents   = resp[:data][:agents]
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
  end
end
