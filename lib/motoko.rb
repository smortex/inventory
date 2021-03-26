# frozen_string_literal: true

require 'motoko/formatter'
require 'motoko/formatter/column/base'
require 'motoko/formatter/column/cpu'
require 'motoko/formatter/column/fact'
require 'motoko/formatter/column/identity'
require 'motoko/formatter/column/os'
require 'motoko/formatter/column/reboot_required'
require 'motoko/formatter/column/formatters/base'
require 'motoko/formatter/column/formatters/boolean'
require 'motoko/formatter/column/formatters/datetime'
require 'motoko/formatter/column/formatters/datetime_ago'
require 'motoko/formatter/column/formatters/ellipsis'
require 'motoko/formatter/column/formatters/timestamp'
require 'motoko/formatter/column/formatters/timestamp_ago'
require 'motoko/config'
require 'motoko/node'
require 'motoko/option_parser'
require 'motoko/version'

module Motoko
  class Error < StandardError; end
  # Your code goes here...
end
