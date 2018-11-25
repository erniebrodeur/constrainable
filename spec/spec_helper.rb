require "bundler/setup"
require 'bundler/setup'
require 'simplecov'
require 'pry'
require_relative 'spec_helper_shared_context'

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.example_status_persistence_file_path = "tmp/rspec_status"
end

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter
]

SimpleCov.start do
  add_filter '/spec/'
end

require "constrainable"
