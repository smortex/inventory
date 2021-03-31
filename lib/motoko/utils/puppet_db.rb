module Motoko
  module Utils
    module PuppetDB
      def self.class_filter(klass)
        operator = '='

        if klass =~ %r{\A/.*/\z}
          klass = klass[1..-2]
          operator = '~'
        end

        "certname in resources[certname] { type = 'Class' and title #{operator} '#{klass.split('::').map(&:capitalize).join('::')}' }"
      end

      def self.fact_filter(fact)
        name, operator, value = fact.split(/([!<>]?=|[<>])/, 2)

        if operator == '=' && value =~ %r{\A/.*/\z}
          value = value[1..-2]
          operator = '~'
        end

        begin
          value = case value
                  when 'true' then true
                  when 'false' then false
                  else Integer(value)
                  end
        rescue
          value = "'#{value}'"
        end

        "certname in inventory[certname] { facts.#{name} #{operator} #{value} }"
      end

      def self.identity_filter(identity)
        operator = '='

        if identity =~ %r{\A/.*/\z}
          identity = identity[1..-2]
          operator = '~'
        end

        "certname #{operator} '#{identity}'"
      end
    end
  end
end
