require 'uri'


module Pubtml
  class Data
    def initialize(data={})
      @data = {}
      merge!(data)
    end

    def merge!(data)
      data.each do |key, value|
        value.encode! Encoding::UTF_8 if value.is_a? String
        self[key.to_sym] = value
      end
    end

    def [](key)
      @data[key.to_sym]
    end

    def []=(key, value)
      if value.class == Hash
        @data[key.to_sym] = Data.new(value)
      else
        @data[key.to_sym] = value
      end
    end

    def each &block
      @data.each &block
    end

    def method_missing(sym, *args)
      if sym.to_s =~ /(.+)=$/
        self[$1] = args.first
      else
        self[sym]
      end
    end
  end

  class Document < Pubtml::Data
    attr_reader :options, :asset_types

    def initialize options={}
      super defaults
      merge! options
    end

    def defaults
      @asset_types = {
        :scripts  => {
          :ext  => 'js',
          :dir  => 'scripts',
          :html => %{<script src="!file" type="text/javascript"></script>}
        },
        :styles   => {
          :ext  => 'css',
          :dir  => 'styles',
          :html => %{<link rel="stylesheet" href="!file" type="text/css" />}
        }
      }

      {
        :title          => 'Pubtml',
        :language       => 'en',
        :author          => '<em>N.N.</em>',
        :default_build  => 'html',
        :project_path   => Dir.pwd,
        :default_project_path => File.expand_path('../../../project', __FILE__),
        :build_path     => 'build',
        :skeleton       => 'skeleton.erb',
        :assets         => {
          :scripts  => ['pubtml'],
          :styles   => ['pubtml']
        },
        :princexml      => {
          :executable   => 'prince'
        }
      }
    end
    def file_locations
      [self[:project_path], self[:default_project_path]]
    end
    def asset asset, type
      file = asset + '.' + @asset_types[type][:ext]
      if not URI(file).absolute? then
        file = File.join(@asset_types[type][:dir], file)
      end
      file
    end

    def name
      name = self[:name]
      name = self[:title] if name.nil?
      name = 'build' if name.nil?
      name.downcase.gsub(/[^A-z0-9\-_\.]/, '-').gsub(/-{2,}/, '-')
    end

    def find_file file
      locations = file_locations
      locations.each do |dir|
        path = File.join(dir, file)
        return path if File.file?(path)
      end
      raise "could not find file #{file} in #{locations.join(", ")}"
    end
  end
end
