# frozen_string_literal: true

require 'date'

module Motoko
  module Formatters
    class Timestamp < BaseFormatter
      def format(value)
        Time.at(Integer(value)).getlocal.to_s
      rescue ArgumentError, TypeError
        nil
      end
    end
  end
end
