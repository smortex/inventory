# frozen_string_literal: true

require 'inventory/formatter'
require 'inventory/formatter/column/base'
require 'inventory/formatter/column/cpu'
require 'inventory/formatter/column/fact'
require 'inventory/formatter/column/identity'
require 'inventory/formatter/column/os'
require 'inventory/formatter/column/reboot_required'
require 'inventory/formatter/column/formatters/base'
require 'inventory/formatter/column/formatters/boolean'
require 'inventory/formatter/column/formatters/datetime'
require 'inventory/formatter/column/formatters/datetime_ago'
require 'inventory/formatter/column/formatters/ellipsis'
require 'inventory/formatter/column/formatters/timestamp'
require 'inventory/formatter/column/formatters/timestamp_ago'
require 'inventory/config'
require 'inventory/node'
require 'inventory/option_parser'
require 'inventory/version'

module Inventory
  class Error < StandardError; end
  # Your code goes here...
end
