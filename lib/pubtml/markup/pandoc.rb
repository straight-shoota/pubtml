module Pubtml
  module Markup
    class Pandoc
      include Markup::Abstract

      def initialize
        @name = "pandoc converter"
        @supported = %w{md markdown textile rst tex latex docbook xml}
      end
      def process file
        command = "pandoc #{file} -t html5"
        e = IO.popen(command, 'r', :external_encoding => Encoding::UTF_8) do |io|
          io.gets nil
        end
        #e.encode! Encoding::UTF_8
      end
    end
    register Pandoc.new()
  end
end
