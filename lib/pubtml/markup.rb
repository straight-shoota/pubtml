

module Pubtml
  module Markup
    module Abstract
      name = nil
      supported = []
      attr_accessor :name, :supported

      def process file
        load file
      end
      def supports? file
        false
      end
      def ext file
        File.extname(file)[1..-1]
      end

      def load file
        s = File.read(file)
        s.encode Encoding::UTF_8
      end
      def supports? file
        #puts inspect
        supported.include? ext file
      end
    end

    class Plain
      include Markup::Abstract
      def initialize
        @name = "plain text"
      end
      def process file
        load file
      end
      def supports? file
        true
      end
    end

    @@handlers = []
    @@default_handler = Plain.new
    def load file
      #puts "loading #{file}"
      @@handlers.each do |handler|
        return handler.process file if handler.supports? file
      end
      return @@default_handler.process file if @@default_handler.supports? file

      raise "could not load file #{file}"
    end

    def register handler
      @@handlers << handler
    end

    module_function :load, :register

    #register Plain.new
  end
end

