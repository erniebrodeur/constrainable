require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Generate (touch) all files in spec from lib'
task :generate_spec_files do
  FileUtils.mkdir_p 'spec/containable'
  Dir.glob('lib/**/*.rb').each do |f|
    new_f = "#{}_spec.rb"
    FileUtils.touch f.gsub('lib', 'spec')
  end
end

desc 'Update .rubocop.yml from gist'
task :update_rubocop do
  sh 'curl -O https://gist.githubusercontent.com/erniebrodeur/f7f63996ef1e017aee9bf9d8e680a1df/raw/fbc2fbb7d111d939db5491f26b5d1f6a97c9f5ed/.rubocop.yml'
end
