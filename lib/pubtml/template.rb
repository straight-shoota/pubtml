require "erb"

module Pubtml
  class Template
    @@default_options = {
      :paths => {},
      :scripts => [],
      :styles => []
    }
    def initialize options = {}
      @options = @@default_options.merge(options)
      puts @options.inspect
    end

    def import(glob)
      s = ""
      Dir.glob glob do |file|
        if File.directory? file
          s += import(file + "/*")
        end
        if File.file? file
          s << Pubtml::Markup.load(file)
        end
      end
      return s
    end

    def scripts
      s = []
      @options[:scripts].each do |script|
        file = File.join(path(:script), script + ".js")
        s << %{<script src="#{file}" type="text/javascript"></script>}
      end
      s.join "\n"
    end
    def styles
      s = []
      @options[:styles].each do |style|
        file = File.join(path(:style), style + ".css")
        s << %{<link rel="stylesheet" href="#{file}" type="text/css" />}
      end
      s.join "\n"
    end
    def lang
      "de"
    end
    def path name
      @options[:paths][name] || name.to_s
    end


    def render(file)
      puts "rendering #{file}...\n"

      erb = ERB.new(load(file))
      erb.filename = file
      #lang = "de"
      return erb.result binding
    end
    def load file
      File.read(file)
    end
    def markdown file
      call = "pandoc #{file} --to=html5"
      puts call
      result = ""
      IO.popen(call, "w+") do |pipe|
        result = pipe.gets(nil)
      end
      result
    end
  end
end
