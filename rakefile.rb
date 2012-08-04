require 'pubtml'
require 'rake/clean'

FINAL = 'thesis.pdf'

BUILD_DIR = 'build/'

CLEAN.include(BUILD_DIR)
CLOBBER.include(FINAL)

def build relative_path = ""
  # avoids duplicating the build location in the build file
  return File.join(BUILD_DIR, relative_path)
end

MARKDOWN = FileList['content/*.md']
HTML = MARKDOWN.pathmap(BUILD_DIR + "%X.html")

task :default => :pdf
task :content => HTML

MARKDOWN.each do |src|
  file build(src.pathmap("%X.html")) => src do |t|
    Pubtml.markup t.prerequisites[0], t.name
  end
end

directory build
directory build("content")

task :html => build(FINAL + '.html')
file build(FINAL.ext('html')) => [build('skeleton.erb'), HTML] do |t|
  Pubtml.pack t.prerequisites[0], t.name
end

task :skeleton => build('skeleton.erb')

file build('skeleton.erb') => build
file build('skeleton.erb') do |t|
  if File.exists? 'skeleton.erb'
    cp 'skeleton.erb', t.name
  else
    File.open(t.name, "w") { |file| file.write(Pubtml.skeleton) }
  end
end

task :pdf => FINAL
file FINAL => build(FINAL.ext('html')) do |t|
  Pubtml.prince t.prerequisites[0], t.name
end

#sass = File.load(sass_file)
#engine = Sass::Engine.new(sass)
#css = engine.render
