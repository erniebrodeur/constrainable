lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "constrainable/version"

Gem::Specification.new do |spec|
  spec.name          = "constrainable"
  spec.version       = Constrainable::VERSION
  spec.authors       = ["Ernie Brodeur"]
  spec.email         = ["ebrodeur@ujami.net"]

  spec.summary       = "A mix/gem to provide common programatic constraints."
  spec.description   = "."
  spec.homepage      = "https://github.com/erniebrodeur/constrainable"

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
