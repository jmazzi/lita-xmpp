Gem::Specification.new do |spec|
  spec.name          = "lita-xmpp"
  spec.version       = "1.0.1"
  spec.authors       = ["Justin Mazzi"]
  spec.email         = ["jmazzi@gmail.com"]
  spec.description   = %q{A XMPP adapter for Lita.}
  spec.summary       = %q{A XMPP adapter for the Lita chat robot.}
  spec.homepage      = "https://github.com/jmazzi/lita-xmpp"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", "~> 2.0"
  spec.add_runtime_dependency "xmpp4r", "~> 0.5"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
