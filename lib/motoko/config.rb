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
      load_project_config
    end

    def load_system_config
      [
        '/usr/local/etc/motoko',
        '/etc/motoko',
      ].each do |d|
        if File.directory?(d)
          load_config(d)
          break
        end
      end
    end

    def load_user_config
      d = File.expand_path('~/.config/motoko')
      load_config(d) if File.directory?(d)
    end

    def load_project_config
      load_classes('.motoko')
      load_only_config('.motoko.yaml')
    end

    def load_config(directory)
      load_classes(directory)
      load_only_config(File.join(directory, 'config.yaml'))
    end

    def load_only_config(filename)
      return unless File.readable?(filename)

      config = YAML.safe_load(File.read(filename))

      @columns = config.delete('columns') if config.key?('columns')
      @sort_by = config.delete('sort_by') if config.key?('sort_by')

      @shortcuts.merge!(config.delete('shortcuts')) if config.key?('shortcuts')
      @columns_spec.merge!(config.delete('columns_spec')) if config.key?('columns_spec')
    end

    def load_classes(directory)
      Dir["#{directory}/formatters/*.rb", "#{directory}/resolvers/*.rb"].sort.each do |file|
        require File.expand_path(file)
      end
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
        memory:
          fact: memory.system.total
          align: right
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
