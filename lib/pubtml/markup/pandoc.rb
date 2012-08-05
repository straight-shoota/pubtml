module Pubtml
  module Markup
    class Pandoc
      include Markup::Abstract

      def initialize
        @name = "pandoc converter"
        @supported = %w{md markdown textile rst tex latex docbook xml}
      end
      def process file
        command = "pandoc #{file}"
        Tool.exec command
      end
    end
    register Pandoc.new()
  end
end
