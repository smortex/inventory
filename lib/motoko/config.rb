# frozen_string_literal: true

require 'yaml'

module Motoko
  class Config
    attr_accessor :columns, :sort_by, :columns_spec, :shortcuts

    def initialize
      @columns = %w[host customer role]
      @sort_by = %w[customer host]
      @shortcuts = Hash.new { {} }
      @columns_spec = Hash.new { {} }.merge(default_columns_spec)

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

      @shortcuts.merge!(config.delete('shortcuts')) if config.key?('shortcuts')
      @columns_spec.merge!(config.delete('columns_spec')) if config.key?('columns_spec')
    end

    def default_columns_spec
      YAML.safe_load(<<~COLUMNS_SPEC)
        ---
        host:
          resolver: identity
        customer:
          formatter: ellipsis
          max_length: 20
        cpu:
          resolver: cpu
        os:
          resolver: os
          human_name: Operating System
        reboot_required:
          resolver: reboot_required
          formatter: boolean
          human_name: R
      COLUMNS_SPEC
    end
  end
end
