# frozen_string_literal: true

require 'motoko/utils'

require 'date'

module Motoko
  class Formatter
    module Column
      module Formatters
        class DatetimeAgo < Base
          include Motoko::Utils::TimeAgo

          def format(value)
            return nil unless value

            seconds_to_human(Time.now - DateTime.parse(value).to_time)
          rescue ArgumentError
            nil
          end
        end
      end
    end
  end
end
