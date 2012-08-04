require "erb"
module Pubtml
  class Template
    css_path = '/build/style/'
    js_path  = '/script/'
    #content_path = '/content/'

    def self.import(glob)
      s = ""
      Dir.glob glob do |file|
        if File.directory? file
          s += import file + "/*"
        end
        if File.file? file
          if DEBUG
            s += "<!-- imported file: #{file} -->\n"
          end
          s += renderTemplate file
        end
      end
      return s
    end

    def selfcss file
      return css_path + file
    end
    def self.js file
      return js_path + file
    end

    def self.renderTemplate(file)
      puts "rendering #{file}...\n"
      erb = ERB.new(File.read(file))
      erb.filename = file
      return erb.result binding
    end
  end
end
