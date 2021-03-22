# frozen_string_literal: true

module Inventory
  class Formatter
    module Column
      module Formatters
        class Boolean < Base
          def format(value)
            value ? '√' : nil
          end
        end
      end
    end
  end
end
