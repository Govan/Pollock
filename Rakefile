require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "pollock"
    gem.summary = %Q{Generate placeholders for html wireframing without going near Photoshop}
    gem.description = %Q{A little Sinatra and RMagick to generate placeholder images via an http call.  Heavily inspired by http://placehold.it}
    gem.email = "gavin@leftbrained.co.uk"
    gem.homepage = "http://github.com/govan/pollock"
    gem.authors = ["Gavin Montague"]
    
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.add_dependency "rmagick", ">= 0"
    gem.add_dependency "sinatra", ">= 0"
    
    gem.executables = "pollockserver"
    
    gem.files =  FileList["[A-Z]*", "{bin,lib,public,test}/**/*", 'lib/jeweler/templates/.gitignore']
    
    
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "pollock #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
