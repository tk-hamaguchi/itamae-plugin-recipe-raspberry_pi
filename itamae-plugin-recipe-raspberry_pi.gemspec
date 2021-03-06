# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itamae/plugin/recipe/raspberry_pi/version'

Gem::Specification.new do |spec|
  spec.name          = 'itamae-plugin-recipe-raspberry_pi'
  spec.version       = Itamae::Plugin::Recipe::RaspberryPi::VERSION
  spec.authors       = ['Takahiro HAMAGUCHI']
  spec.email         = ['tk.hamaguchi@gmail.com']

  spec.summary       = 'Raspberry Pi installer with itemae'
  spec.description   = 'Raspberry Pi installer with itemae.'
  spec.homepage      = 'https://github.com/tk-hamaguchi/itamae-plugin-recipe-raspberry_pi'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f|
    f.match(%r{^(test|spec|features)/})
  }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_runtime_dependency 'itamae', '~> 1.4.1'
end
