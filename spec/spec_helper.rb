require "bundler/setup"
require 'bundler/setup'
require 'simplecov'
require 'pry'

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.example_status_persistence_file_path = "tmp/rspec_status"
end

RSpec.shared_context "with harness" do
  before do
    class Harness
      include Constrainable

      # constrain :method, by: { required_keywords: %i[keyword two three] }
      # constrain_class by: { signed_in: true }
    end
  end
end


SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter
]

SimpleCov.start do
  add_filter '/spec/'
end

require "constrainable"
