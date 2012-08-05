

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
        File.read(file)
      end
      def supports? file
        puts inspect
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
    def load file
      #puts "loading #{file}"
      @@handlers.each do |handler|
        return handler.process file if handler.supports? file
      end
      raise 'could not load file #{file}'
    end

    def register handler
      @@handlers << handler
    end

    module_function :load, :register

    #register Plain.new
  end
end

