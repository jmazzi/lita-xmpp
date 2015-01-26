Gem::Specification.new do |spec|
  spec.name          = "lita-xmpp"
  spec.version       = "1.1.0.pre"
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
  spec.metadata = {"lita_plugin_type" => "adapter"}

  spec.add_runtime_dependency "lita", ">= 3.0"
  spec.add_runtime_dependency "xmpp4r"

  spec.add_development_dependency "bundler", "~> 1.7.2"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
