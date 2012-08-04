require "erb"
module Pubtml
  class Template
    css_path = '/build/style/'
    js_path  = '/script/'
    #content_path = '/content/'

    def import(glob)
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

    def css file
      return css_path + file
    end
    def js file
      return js_path + file
    end

    def renderTemplate(file)
      puts "rendering #{file}...\n"
      erb = ERB.new(File.read(file))
      erb.filename = file
      return erb.result binding
    end
    module_function :renderTemplate
  end
end
