# frozen_string_literal: true

require 'skittlize'
require 'terminal-table'

require 'motoko/utils/snake_to_camel'

module Motoko
  class Formatter
    attr_reader :options, :columns_spec, :shortcuts
    attr_accessor :columns, :nodes, :mono, :wide, :count, :sort_by

    include Motoko::Utils::SnakeToCamel

    def initialize
      config = Config.new
      @nodes = []
      @columns = config.columns
      @mono = false
      @wide = false
      @count = false
      @sort_by = config.sort_by
      @columns_spec = config.columns_spec
      @shortcuts = config.shortcuts
    end

    def to_s
      return '' if nodes.empty?

      @rows = nil
      @column_resolvers = nil

      columns.uniq!

      table = ::Terminal::Table.new headings: headings, rows: data
      column_resolvers.each_with_index do |column, idx|
        table.align_column(idx, column.align) if column.align
      end
      table.to_s
    end

    def column_resolvers
      @column_resolvers ||= columns.map do |column|
        klass = columns_spec[column].delete('resolver') || 'Fact'

        Object.const_get("Motoko::Resolvers::#{snake_to_camel_case(klass)}").new(column, columns_spec[column])
      end
    end

    def data
      return @data if @data

      @data = sorted_nodes.map! do |node|
        column_resolvers.map do |column|
          column.value(node)
        end
      end

      @data.skittlize! unless mono

      @data
    end

    def headings
      header = column_resolvers.each_with_index.map do |column, idx|
        name = column.human_name
        if count
          different_values = data.map { |line| line[idx] }.uniq.compact.count
          name += " (#{different_values})" if different_values > 1
        end
        {
          value: mono ? name : "\e[1m#{name}\e[0m",
          alignment: :center,
        }
      end
    end

    def sorted_nodes
      nodes.sort_by { |a| sort_by.map { |c| a.fact(c) || '' } + [a.identity] }
    end
  end
end
