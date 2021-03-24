# frozen_string_literal: true

require 'inventory/utils'

require 'date'

module Inventory
  class Formatter
    module Column
      module Formatters
        class TimestampAgo < Base
          include Inventory::Utils::TimeAgo

          def format(value)
            return nil unless value

            seconds_to_human(Time.now - Time.at(Integer(value)))
          rescue ArgumentError
            nil
          end
        end
      end
    end
  end
end
