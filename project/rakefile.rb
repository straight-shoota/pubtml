require 'pubtml'
require 'rake/clean'

PUBTML_RAKE_FILE = __FILE__

options = {
  :paths => {
    :style => 'style'
  },
  :scripts => ['lib/jquery-1.7.2', 'lib/outliner', 'pubtml', 'pubtml/footnote', 'pubtml/toc'],
  :styles => ['pubtml']
}

FINAL = 'out.pdf'

BUILD_DIR = 'build/'

CLEAN.include(BUILD_DIR)
CLOBBER.include(FINAL)

def build relative_path = ""
  # avoids duplicating the build location in the build file
  return File.join(BUILD_DIR, relative_path)
end

task :default => :pdf

directory build

task :html => [build(FINAL.ext('html')), :style, :script]

file build(FINAL.ext('html')) => build do |t|
  Pubtml.pack 'skeleton.erb', t.name, options
end

task :pdf => FINAL
task FINAL => :html
file FINAL => build(FINAL.ext('html')) do |t|
  Pubtml.prince build(FINAL.ext('html')), t.name
end

task :style => build('style')
directory build('style')

task :style do
  #SASS.each do |style|
  #  Pubtml.sass style, build
  #end
  #system "compass compile --force"
end

directory build('script')
task :script => build('script') do
  options[:scripts].each do |script|
    Pubtml.copy_script script, build
  end
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
