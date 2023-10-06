# frozen_string_literal: true

module Motoko
  module Formatters
    class BaseFormatter
      def initialize(options = {})
        # noop
      end

      def format(value)
        case value
        when Array
          value.join("\n")
        when Hash
          value.keys.join("\n")
        else
          value.to_s
        end
      end
    end
  end
end
