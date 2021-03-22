# frozen_string_literal: true

require 'date'

module Inventory
  class Formatter
    module Column
      module Formatters
        class Datetime < Base
          def format(value)
            DateTime.parse(value).to_time.getlocal.to_s
          end
        end
      end
    end
  end
end
