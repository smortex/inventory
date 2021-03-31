# frozen_string_literal: true

module Motoko
  module Formatters
    class Boolean < BaseFormatter
      def format(value)
        value ? '√' : nil
      end
    end
  end
end
