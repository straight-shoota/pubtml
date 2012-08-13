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
        e = IO.popen(command, 'r') do |io|
          io.gets nil
        end
        e
      end
    end
    register Pandoc.new()
  end
end
