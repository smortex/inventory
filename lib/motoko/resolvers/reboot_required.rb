# frozen_string_literal: true

module Motoko
  module Resolvers
    class RebootRequired < BaseResolver
      def resolve_for(node)
        [
          'apt_reboot_required',
          'pkg_reboot_required',
          'yum_reboot_required',
        ].each do |fact|
          value = node.fact(fact)
          return value unless value.nil?
        end

        nil
      end
    end
  end
end
