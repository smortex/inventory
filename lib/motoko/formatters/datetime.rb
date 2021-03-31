# frozen_string_literal: true

require 'date'

module Motoko
  module Formatters
    class Datetime < BaseFormatter
      def format(value)
        DateTime.parse(value).to_time.getlocal.to_s
      rescue ArgumentError
        nil
      end
    end
  end
end
