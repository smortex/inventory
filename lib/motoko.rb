# frozen_string_literal: true

require 'motoko/config'
require 'motoko/formatter'
require 'motoko/formatters/base_formatter'
require 'motoko/formatters/boolean'
require 'motoko/formatters/datetime'
require 'motoko/formatters/datetime_ago'
require 'motoko/formatters/ellipsis'
require 'motoko/formatters/timestamp'
require 'motoko/formatters/timestamp_ago'
require 'motoko/node'
require 'motoko/option_parser'
require 'motoko/resolvers/base_resolver'
require 'motoko/resolvers/cpu'
require 'motoko/resolvers/fact'
require 'motoko/resolvers/identity'
require 'motoko/resolvers/os'
require 'motoko/resolvers/reboot_required'
require 'motoko/version'

module Motoko
  class Error < StandardError; end
  # Your code goes here...
end
