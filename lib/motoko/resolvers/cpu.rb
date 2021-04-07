# frozen_string_literal: true

module Motoko
  module Resolvers
    class Cpu < BaseResolver
      def resolve_for(node)
        format('%<ncpu>2d × %<model>s', ncpu: node.fact('processors.count'), model: node.fact('processors.models').first.gsub(/\((R|TM)\)|Processor/, '').gsub(/ {2,}/, ' '))
      end
    end
  end
end
