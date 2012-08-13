require 'thor'
require 'thor/group'

require 'yaml'

require 'fileutils'

require 'pubtml'
require 'pubtml/document'
require 'pubtml/builder'

module Pubtml
  class App < Thor
    include Thor::Actions

    desc '-v, --version', 'Show Pubtml version number'
    map '-v' => '--version'
    def __version
      require 'pubtml/version'
      puts "Pubtml #{Pubtml::VERSION}"
    end
    desc 'build', "Build total project"
    def build
      clean
      html
      assets
      pdf
    end
    desc 'pdf', 'Create PDF file'
    def pdf
      load_doc
      dest = File.join(@doc[:build_path], "pdf/#{@doc.name}.pdf")
      source = File.join(@doc[:build_path], "html/#{@doc.name}.html")

      html unless File.exists? source

      ::FileUtils.mkdir_p File.join(@doc[:build_path], "pdf")
      run %{"#{@doc[:princexml][:executable]}" -o "#{dest}" --javascript -v "#{source}"}
    end

    desc 'html', 'Build HTML file'
    def html
      load_doc

      builder = Pubtml::Builder.new @doc

      skeleton = @doc.find_file @doc[:skeleton]

      puts "using skeleton #{skeleton}..."

      html = builder.render skeleton
      create_file File.join(@doc[:build_path], "html/#{@doc.name}.html"), html
    end

    desc 'clean', 'Clean generated content'
    def clean
      load_doc

      #Pubtml::Tool.exec %{compass clean "#{@doc[:default_project_path]}"}

      remove_dir @doc[:build_path]
    end

    desc 'styles', 'Create styles'
    def styles
      load_doc
      remove_dir File.join(@doc[:build_path], 'styles')

      css_dir = File.expand_path(File.join(@doc[:build_path], 'html', @doc.asset_types[:styles][:dir]))

      run %{compass compile "#{@doc[:default_project_path]}" --css-dir "#{css_dir}"}
    end
    desc 'scripts', 'Create scripts'
    def scripts
      load_doc

      remove_dir File.join(@doc[:build_path], 'scripts')

      @doc[:assets][:scripts].each do |asset|
        file = @doc.asset asset, :scripts
        dest = File.join(@doc[:build_path], 'html', file)
        copy_file File.join('assets', file), dest
      end
    end

    desc 'assets', 'Create assets'
    def assets
      scripts
      styles
    end

    no_tasks do
      def load_doc
        return @doc if not @doc.nil?
        config = YAML.load_file('config/pubtml.yml')
        @doc = Pubtml::Document.new config

        Pubtml::App.source_root @doc[:default_project_path]
      end
    end
  end
end

