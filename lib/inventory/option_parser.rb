# frozen_string_literal: true

module Inventory
  class OptionParser
    attr_accessor :formatter

    def initialize
      @parser = ::OptionParser.new
      @formatter = Formatter.new
    end

    def parse
      self.class.add_inventory_options(@parser, @formatter)

      yield(@parser, @formatter) if block_given?

      @parser.parse!

      @formatter
    end

    def self.add_inventory_options(parser, formatter)
      parser.separator ''
      parser.separator 'Inventory Options'

      parser.on('-a', '--add-columns=COLUMNS', 'Add COLUMNS to the displayed column list', Array) do |columns|
        formatter.columns += columns
      end

      parser.on('--columns=COLUMNS', 'Set the displayed column list to COLUMNS', Array) do |columns|
        formatter.columns = columns
      end

      parser.on('--hw', 'Display hardware information') do
        formatter.columns += %i[is_virtual cpu memory]
      end

      parser.on('--puppet', 'Display Puppet information') do
        formatter.columns += %i[puppet]
      end

      parser.on('--sw', 'Display sodtware information') do
        formatter.columns += %i[os kernel]
      end

      parser.on('--mono', 'Do not display a colored output') do
        formatter.mono = true
      end

      parser.on('-w', '--wide', 'Do not ellipsis long strings') do
        formatter.wide = true
      end

      parser.on('--[no-]count', 'Count values') do |count|
        formatter.count = count
      end

      parser.on('--sort-by=COLUMNS', 'Sort lines by COLUMS', Array) do |columns|
        formatter.sort_by = columns
      end
    end
  end
end
