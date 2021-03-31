# frozen_string_literal: true

require 'motoko/utils'

require 'date'

module Motoko
  module Formatters
    class TimestampAgo < BaseFormatter
      include Motoko::Utils::TimeAgo

      def format(value)
        return nil unless value

        seconds_to_human(Time.now - Time.at(Integer(value)))
      rescue ArgumentError
        nil
      end
    end
  end
end
