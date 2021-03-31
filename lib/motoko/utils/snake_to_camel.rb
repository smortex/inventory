module Motoko
  module Utils
    module SnakeToCamel
      def snake_to_camel_case(subject)
        subject.split('_').map(&:capitalize).join
      end
    end
  end
end
