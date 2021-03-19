require 'skittlize'
require 'terminal-table'

module Inventory
  class Formatter
    attr_reader :options
    attr_accessor :columns, :nodes
    attr_accessor :mono, :wide, :count, :sort_by

    def initialize
      @nodes = []
      @columns = %i[host customer role]
      @mono = false
      @wide = false
      @count = false
      @sort_by = %i[customer]
    end

    def column_specs
      {
        reboot_required: { name: 'R', align: :center, proc: ->(node) { (node.fact('apt_reboot_required') || node.fact('yum_reboot_required') || node.fact('pkg_reboot_required')) ? '√' : nil } },
        host:            { proc: ->(node) { node.identity } },
        is_virtual:      { name: 'V', align: :center, proc: ->(node) { node.fact('is_virtual') ? '√' : nil } },
        cpu:             { name: 'Central Processor Unit', proc: ->(node) { format('%2d × %s', node.fact('processors.count'), node.fact('processors.models').first.gsub(/\((R|TM)\)|Processor/, '').gsub(/ {2,}/, ' ')) } },
        memory:          { fact: 'memory.system.total', align: :right },
        os:              { name: 'Operating System', proc: ->(node) { node.fact('os.distro.description') || format('%s %s', node.fact('os.name'), node.fact('os.release.full')) } },
        kernel:          { fact: 'kernelrelease' },
        puppet:          { fact: 'puppetversion' },
        odoo:            { fact: 'odoo.release.full' },
        jalios:          { fact: 'jalios.release.full' },
        nginx_vhosts:    { name: 'Virtual Hosts', proc: ->(node) { node.fact('nginx_vhosts') } },
        instance_type:   { fact: 'ec2_metadata.instance-type' },
        customer:        { proc: ->(node) { node.fact('customer') }, max_width: 20 },
      }
    end

    def to_s
      return '' if nodes.empty?

      columns.uniq!

      actual_columns = columns.map do |column|
        { name: column.to_s.tr('_', ' ').gsub('.', ' > ').split.map(&:capitalize).join(' '), fact: column.to_s }.merge(column_specs[column.to_sym] || {})
      end

      nodes.sort_by! { |a| sort_by.map { |c| a.fact(c) || '' } + [a.identity] }

      nodes.map! do |node|
        actual_columns.map do |column|
          if column[:proc]
            res = column[:proc].call(node)
          elsif column[:fact]
            res = node.fact(column[:fact])
          else
            raise 'Bug'
          end

          res = res.to_s unless res.nil?

          if res.is_a?(String) && !wide && column[:max_width] && res.length > column[:max_width]
            res[column[:max_width]..-1] = '…'
          end

          res
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
        name = column[:name]
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
        if column[:align]
          table.align_column(idx, column[:align])
        end
      end
      return table.to_s
    end
  end
end
