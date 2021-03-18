module Inventory
  class Node
    attr_reader :identity, :classes, :agents

    def initialize(resp)
      @identity = resp[:sender]
      @facts    = resp[:data][:facts]
      @classes  = resp[:data][:classes]
      @agents   = resp[:data][:agents]
    end

    def fact(name)
      @facts.dig(*name.to_s.split('.'))
    end
  end
end
