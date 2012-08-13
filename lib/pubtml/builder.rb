require 'erb'

module Pubtml
  class Builder
    def initialize document
      @doc = document
    end

    def import(glob)
      s = ""
      puts "called #{glob}"
      glob = "content/" + glob unless glob[0] == "/" or glob[0,8] == "content/"
      Dir.glob glob do |file|
        if File.basename(file)[0] != "_" then
          if File.directory? file
            index = File.join(file, "index.erb")
            puts "index #{index}"
            if File.file? index then
              s << import(index)
            else
              s << import(File.join("..", file, "*"))
            end
          end
          if File.file? file
            puts "reading #{file}..."
            s << render(file, Pubtml::Markup.load(file))
          end
        end
      end

      # s.gsub!(/<figure/, '<div class="figure"')
      # s.gsub!(/<\/figure>/, '</div>')
      # s.gsub!(/<figcaption/, '<div class="figcaption"')
      # s.gsub!(/<\/figcaption>/, '</div>')
      # s.gsub!(/class="figure" class="code"/, 'class="figure code"')

      # s.sub!(/<footer/, '<div class="footer"')
      # s.sub!(/<\/footer>/, '</div>')

      return s
    end

    def scripts
      assets :scripts
    end
    def styles
      assets :styles
    end
    def assets t
      html = []
      type = @doc.asset_types[t]
      @doc[:assets][t].each do |asset|
        html << type[:html].gsub('!file', @doc.asset(asset, t))
      end
      html.join "\n"
    end

    def render(file, content = nil)
      if content.nil? then
        puts "rendering #{file}...\n"
        content = File.read(file)
      end

      erb = ERB.new(content)
      erb.filename = file
      #lang = "de"
      return erb.result binding
    end

    def cite data
      title = %{<em class="title">#{data[:title]}</em>}
      author = data[:author]
      author = %{<span class="author">#{author}</span>: } unless author.nil?
      date = data[:date]
      date = %{<time datetime="#{date}">#{date}</time>}
      %{<span class="citation">
        #{author}#{title}#{date}
        </span>}
    end
  end
end
