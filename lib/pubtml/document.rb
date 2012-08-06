module Pubtml
  class Document
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def project_directory
      Dir.pwd
    end
    def default_directory
      File.expand_path(File.join(base_directory, 'project'))
    end
    def base_directory
      File.expand_path(File.join(lib_directory, '..'))
    end
    def lib_directory
      File.expand_path(File.join(File.dirname(__FILE__), '..'))
    end
    def file_locations
      [project_directory, default_directory, base_directory]
    end
    def build_directory
      File.expand_path(File.join(project_directory, "build"))
    end

    def find file
      locations = file_locations()
      locations.each do |dir|
        path = File.join(dir, file)
        return path if File.file?(path)
      end
      raise "could not find file #{file} in \n  #{locations.join("\n  ")}"
    end

    def copy_scripts
      options[:script].each do |script|
        file = "script/#{script}.js"
        Tool.copy find(file), File.join(build_directory, file)
      end
    end
  end

end
