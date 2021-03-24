# frozen_string_literal: true

module Inventory
  module Utils
    module SnakeToCamel
      def snake_to_camel_case(subject)
        subject.split('_').map(&:capitalize).join
      end
    end

    module TimeAgo
      def seconds_to_human(value)
        return nil unless value

        value = value.round
        res = []

        {
          's' => 60,
          'm' => 60,
          'h' => 24,
        }.each do |unit, count|
          res << sprintf('%2d%s', value % count, unit)
          value /= count

          break if value.zero?
        end

        res << "#{value}d" if value.positive?

        res.reverse.join(' ')
      end
    end
  end
end
