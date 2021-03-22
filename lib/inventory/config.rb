# frozen_string_literal: true

require 'yaml'

module Inventory
  class Config
    attr_accessor :columns, :sort_by, :columns_spec

    def initialize
      @columns = %w[host customer role]
      @sort_by = %w[customer host]
      @columns_spec = Hash.new { {} }

      load_system_config
      load_user_config
    end

    def load_system_config
      [
        '/usr/local/etc/motoko/config.yaml',
        '/etc/motoko/config.yaml'
      ].each do |f|
        if File.readable?(f)
          load_config(f)
          break
        end
      end
    end

    def load_user_config
      f = File.expand_path('~/.config/motoko/config.yaml')

      load_config(f) if File.readable?(f)
    end

    def load_config(filename)
      config = YAML.safe_load(File.read(filename))

      @columns = config.delete('columns') if config.key?('columns')
      @sort_by = config.delete('sort_by') if config.key?('sort_by')

      @columns_spec.merge!(config.delete('columns_spec')) if config.key?('columns_spec')
    end
  end
end
