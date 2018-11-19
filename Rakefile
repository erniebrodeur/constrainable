require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "open-uri"
### Configurables

FILES = {
  Gemfile:  'https://gist.githubusercontent.com/erniebrodeur/5a5518f5051210f1828a0712bf623dc8/raw',
  Rakefile: 'https://gist.githubusercontent.com/erniebrodeur/afc92b72158413aa1f85d8d1facd267a/raw',
  Rubocop:  'https://gist.githubusercontent.com/erniebrodeur/f7f63996ef1e017aee9bf9d8e680a1df/raw',
  Tasks:    'https://gist.githubusercontent.com/erniebrodeur/03573fecf4f274101c14f6802abdbe83/raw'
}.freeze

# spec
RSpec::Core::RakeTask.new(:spec)
task default: :spec

desc 'Generate (touch) all Files in spec from lib'
task :generate_spec_files do
  Dir.glob('lib/**/*.rb').each do |f|
    spec_file = f.gsub(/^lib/, "spec").gsub(/.rb$/, "_spec.rb")
    mkdir_p File.dirname spec_file
    touch spec_file
  end
end

desc 'generate a require block'
task :generate_require_block do
  puts Dir.glob("lib/**/*.rb").map { |d| "require \"#{d.gsub('lib/', '')}\"" }.sort
end

# automagical updating
desc "updates for various bits of the development environment."

namespace :update do
  desc "update everything (multitasked)"
  multitask(all: %i[gemfile rakefile rubocop tasks])

  desc 'Update Gemfile from gist'
  task :gemfile do
    grab_file 'Gemfile', FILES[:Gemfile]
  end

  desc 'Update Rakefile from gist'
  task :rakefile do
    grab_file 'Rakefile', FILES[:Rakefile]
  end

  desc 'Update .rubocop.yml from gist'
  task :rubocop do
    grab_file '.rubocop.yml', FILES[:Rubocop]
  end

  desc 'Update .vscode/tasks.json from gist'
  task :tasks do
    mkdir_p '.vscode'
    grab_file '.vscode/tasks.json', FILES[:Rubocop]
  end
end

def grab_file(filename, uri)
  File.write filename, open(uri).read
  puts "Updated #{filename} from: #{uri}"
end
