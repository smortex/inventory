# frozen_string_literal: true

require 'skittlize'
require 'terminal-table'

require 'inventory/utils'

module Inventory
  class Formatter
    attr_reader :options, :columns_spec
    attr_accessor :columns, :nodes, :mono, :wide, :count, :sort_by

    include Inventory::Utils::SnakeToCamel

    def initialize
      config = Config.new
      @nodes = []
      @columns = config.columns
      @mono = false
      @wide = false
      @count = false
      @sort_by = config.sort_by
      @columns_spec = config.columns_spec
    end

    def to_s
      return '' if nodes.empty?

      columns.uniq!

      actual_columns = columns.map do |column|
        klass = columns_spec[column].delete('resolver') || 'Fact'

        Object.const_get("Inventory::Formatter::Column::#{snake_to_camel_case(klass)}").new(column, columns_spec[column])
      end

      nodes.sort_by! { |a| sort_by.map { |c| a.fact(c) || '' } + [a.identity] }

      nodes.map! do |node|
        actual_columns.map do |column|
          column.value(node)
        end
      end

      nodes.skittlize! unless mono

      rows = nodes.map do |row|
        row.map do |col|
          if col.is_a?(Array)
            col.join("\n")
          else
            col
          end
        end
      end

      header = actual_columns.each_with_index.map do |column, idx|
        name = column.human_name
        if count
          different_values = rows.map { |line| line[idx] }.uniq.compact.count
          name += " (#{different_values})" if different_values > 1
        end
        {
          value: mono ? name : "\e[1m#{name}\e[0m",
          alignment: :center,
        }
      end
      table = ::Terminal::Table.new headings: header, rows: rows
      actual_columns.each_with_index do |column, idx|
        table.align_column(idx, column.align) if column.align
      end
      table.to_s
    end
  end
end
