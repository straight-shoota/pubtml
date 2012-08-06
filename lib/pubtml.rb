$:.unshift(File.dirname(__FILE__))

require 'pubtml/document'
require 'pubtml/template'
require "pubtml/markup"
require "pubtml/markup/pandoc"

module Pubtml
  class Document
    def prince
      source = options[:html]
      target = options[:pdf]
      #puts "prince: #{source} => #{target}"
      #system "prince #{html_file} -o #{out} --javascript"
      prince = 'C:\Program Files (x86)\Prince\Engine\bin\prince.exe'
      command = %{"#{prince}" -o "#{target}" --javascript -v "#{source}"}

      Tool.exec command
    end
    def pack file = nil
      file = options[:skeleton] if file.nil?

      options[:skeleton] = file
      source = find(file)
      target = options[:html]
      puts "creating #{target} (based on #{options[:skeleton]})..."
      template = Pubtml::Template.new options
      html = ""
      html = template.render source

      Tool.write html, target
    end

    def sass file, dir
      require 'sass'
      source = "style/#{file}.scss"
      target = File.join(dir, source)
      source = find(source)
      #engine = Sass::Engine.new(File.read(source))
      #write engine.render, target
      require 'fileutils'
      mkdir_p File.dirname(target)
      Tools.copy source, target
    end
  end

  module Tool
    def exec command, input = nil, read = true
       mode = if input.nil? then "r" else "w+" end
       puts "exec: #{command}"
       IO.popen(command, mode) do |io|
         io.puts(input) if not input.nil?
         io.gets nil if read
       end
    end
    def copy src, des
      require 'fileutils'
      mkdir_p File.dirname(des)
      cp src, des
    end

    def write string, file
      File.open(file, "w") do |f| f.write(string) end
    end
    module_function :exec, :copy, :write
  end
end
