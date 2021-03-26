# frozen_string_literal: true

require 'date'

module Motoko
  class Formatter
    module Column
      module Formatters
        class Timestamp < Base
          def format(value)
            Time.at(Integer(value)).getlocal.to_s
          rescue ArgumentError
            nil
          end
        end
      end
    end
  end
end
