require 'pubtml'
require 'rake/clean'

PUBTML_RAKE_FILE = __FILE__

options = {
  :paths => {
    :style => 'style',
  },
  :script => ['lib/jquery-1.7.2', 'lib/outliner', 'pubtml', 'pubtml/footnote', 'pubtml/toc'],
  :style => ['pubtml'],
  :html => 'out.html',
  :pdf => 'out.pdf',
  :build => 'build',
  :skeleton => 'skeleton.erb'
}

CLEAN.include(options[:build])
CLOBBER.include(options[:pdf])

document = Pubtml::Document.new options

task :default => [:clean, :pdf]

task :html => [:style, :script] do |t|
  document.pack
end

task :pdf  => :html do |t|
  document.prince
end

task :style do
  #SASS.each do |style|
  #  Pubtml.sass style, build
  #end
  #system "compass compile --force"
end

task :script do
  document.copy_scripts
end

desc "Compile to compressed css"
task :compile_compressed do
  #Go to the compass project directory
  #Dir.chdir File.join( ENV['base_path'], CONF['dir']['compass'] ) do |dir|
  #  file_compass_config = "/path/to/some/different/config.rb"
#
  #  system "compass compile -c #{file_compass_config} --force"
  #end
end
