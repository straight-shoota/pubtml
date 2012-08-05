$:.unshift(File.dirname(__FILE__))

module Pubtml
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
    File.expand_path(File.join(File.dirname(__FILE__)))
  end
  def file_locations
    [project_directory, default_directory, base_directory]
  end
  def find file
    locations = file_locations()
    locations.each do |dir|
      path = File.join(dir, file)
      return path if File.file?(path)
    end
    raise "could not find file #{file} in \n  #{locations.join("\n  ")}"
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

  def pack (base, target, options)
    source = find(base)
    puts "creating #{target} (based on #{base})..."
    require 'pubtml/template'
    template = Pubtml::Template.new options
    html = ""
    html = template.render source

    write html, target
  end
  def markup (source, target)
    source = find(source)
    puts "markup: #{source} => #{target}"
    call = "pandoc "
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
    cp source, target
  end
  def copy src, des
    des = File.join(des, src)
    require 'fileutils'
    mkdir_p File.dirname(des)
    cp find(src), des
  end
  def copy_script file, dir
    copy "script/#{file}.js", dir
  end

  def write string, file
    File.open(file, "w") do |f| f.write(string) end
  end

  module_function :project_directory, :base_directory, :lib_directory, :default_directory, :prince, :pack, :markup, :file_locations, :find, :sass, :copy_script, :copy, :write

end
