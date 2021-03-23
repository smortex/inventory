# frozen_string_literal: true

require 'inventory/utils'

module Inventory
  class Formatter
    module Column
      class Base
        attr_accessor :name
        attr_writer :human_name
        attr_reader :formatter

        include Inventory::Utils::SnakeToCamel

        def initialize(name, options)
          options ||= {}

          @name = name
          @human_name = options.delete('human_name') if options.key?('human_name')
          @formatter = options.delete('formatter') if options.key?('formatter')
          @align = options.delete('align')

          @formatter = Object.const_get("Inventory::Formatter::Column::Formatters::#{snake_to_camel_case(@formatter)}").new(options) if @formatter

          puts "unused keys for column #{name}: #{options.keys.join(', ')}" if options.keys.any?
        end

        def align
          @align&.to_sym
        end

        def human_name
          @human_name ||= name.tr('_', ' ').gsub('.', ' > ').split.map(&:capitalize).join(' ')
        end

        def resolve_for(node)
          node.fact(name)
        end

        def value(node)
          value = resolve_for(node)

          value = formatter.format(value) if formatter

          value
        end
      end
    end
  end
end
