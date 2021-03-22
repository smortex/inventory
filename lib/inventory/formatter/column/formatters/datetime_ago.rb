# frozen_string_literal: true

require 'inventory/utils'

require 'date'

module Inventory
  class Formatter
    module Column
      module Formatters
        class DatetimeAgo < Base
          include Inventory::Utils::TimeAgo

          def format(value)
            retunr nil unless value

            seconds_to_human(Time.now - DateTime.parse(value).to_time)
          end
        end
      end
    end
  end
end
