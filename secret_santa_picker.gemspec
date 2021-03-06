
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "secret_santa_picker/version"

Gem::Specification.new do |spec|
  spec.name          = "secret_santa_picker"
  spec.version       = SecretSantaPicker::VERSION
  spec.authors       = ["Sean"]
  spec.email         = ["scashin133@gmail.com"]

  spec.summary       = %q{Quickly and secretly do secret santa}
  spec.description   = %q{Send emails to a list of secret santa participants}
  spec.homepage      = "https://github.com/scashin133/secret_santa_picker"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "mail", ">= 2.7"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
end
