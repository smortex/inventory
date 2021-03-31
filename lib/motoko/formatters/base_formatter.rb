# frozen_string_literal: true

module Motoko
  module Formatters
    class BaseFormatter
      def initialize(options = {}) end

      def format(_value)
        raise 'Not implemented'
      end
    end
  end
end
