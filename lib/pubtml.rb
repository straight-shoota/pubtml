$:.unshift(File.dirname(__FILE__))

module Pubtml
  def base_directory
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end
  def lib_directory
    File.expand_path(File.join(File.dirname(__FILE__)))
  end

  def skeleton
    return '<html><head></head><body><%= import("sections") %></body></html>'
  end
  def prince (source, target)
    source = find(source)
    #puts "prince: #{source} => #{target}"
    #system "prince #{html_file} -o #{out} --javascript"
    prince = 'C:\Program Files (x86)\Prince\Engine\bin\prince.exe'
    call = "\"#{prince}\" -o #{target} --javascript -v #{source}"
    puts call

    system call or puts $?
  end

  def pack (source, target)
    source = find(source)
    puts "pack: #{source} => #{target}"
    require 'pubtml/erb'
    html = Pubtml::Template.renderTemplate source
    write html, target
  end
  def markup (source, target)
    source = find(source)
    puts "markup: #{source} => #{target}"
    call = "pandoc "
  end
  def file name=""
    File.expand_path(File.join(File.dirname(__FILE__), '..' , name))
  end
  def find file
    if File.file? file
      return file
    end
    if File.file? file(file)
      return file(file)
    end
    raise "could not find file #{file}"
  end
  def sass file, dir
    require 'sass'
    source = "style/#{file}.scss"
    target = File.join(dir, source)
    source = find(source)
    #engine = Sass::Engine.new(File.read(source))
    #write engine.render, target
    require 'fileutils'
    cp source, target
  end
  def script file, dir
    source = "script/#{file}.js"
    target = File.join(dir, source)
    source = find(source)
    require 'fileutils'
    cp source, target
  end

  def write string, file
    File.open(file, "w") do |f| f.write(string) end
  end

  module_function :base_directory, :lib_directory, :skeleton, :prince, :pack, :markup, :file, :find, :sass, :script, :write

end
