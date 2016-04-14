lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rust_example/version'

Gem::Specification.new do |spec|
  spec.name          = "rust_example"
  spec.version       = RustExample::VERSION
  spec.authors       = ["Sean Griffin"]
  spec.email         = ["sean@seantheprogrammer.com"]
  spec.summary       = %q{Fast string replacement}
  spec.description   = %q{Fast string replacement}
  # spec.homepage      = "none"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.platform = Gem::Platform::CURRENT

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.extensions << "ext/rust_example/extconf.rb"
end
