require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Generate (touch) all files in spec from lib'
task :generate_spec_files do
  FileUtils.mkdir_p 'spec/containable'
  Dir.glob('lib/**/*.rb').each do |f|
    FileUtils.touch "#{f.gsub('lib', 'spec')}_spec_rb"
  end
end

desc "updates for various bits of the development environment."
namespace :update do
  desc 'Update Gemfile from gist'
  task :gemfile do
    sh 'curl -O https://gist.githubusercontent.com/erniebrodeur/5a5518f5051210f1828a0712bf623dc8/raw/0414f1c83ef87a530de58e1751fdfb1838af8615/Gemfile'
  end

  desc 'Update Rakefile from gist'
  task :rakefile do
    sh 'curl -O https://gist.githubusercontent.com/erniebrodeur/afc92b72158413aa1f85d8d1facd267a/raw/c120a77a8d480fdcbd4b7264f7d2ed764634c4d5/Rakefile'
  end

  desc 'Update .rubocop.yml from gist'
  task :rubocop do
    sh 'curl -O https://gist.githubusercontent.com/erniebrodeur/f7f63996ef1e017aee9bf9d8e680a1df/raw/fbc2fbb7d111d939db5491f26b5d1f6a97c9f5ed/.rubocop.yml'
  end
end
