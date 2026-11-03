# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name          = 'w002yardprobe'
  s.version       = '0.0.1'
  s.summary       = 'Documentation build pipeline probe (w002)'
  s.description   = 'Minimal probe gem used to verify YARD doc generation behavior on documentation hosting services.'
  s.authors       = ['w002-research']
  s.email         = 'w002-research@example.org'
  s.homepage      = 'https://github.com/w002-research/w002yardprobe'
  s.license       = 'MIT'
  s.required_ruby_version = '>= 3.0'
  s.files         = Dir['lib/**/*.rb'] + ['README.md', '.yardopts', 'script.rb']
  s.require_paths = ['lib']
end
