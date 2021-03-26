# frozen_string_literal: true

require 'date'

module Motoko
  class Formatter
    module Column
      module Formatters
        class Datetime < Base
          def format(value)
            DateTime.parse(value).to_time.getlocal.to_s
          rescue ArgumentError
            nil
          end
        end
      end
    end
  end
end
