# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ecloud_cpi/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Dr Nic Williams"]
  gem.email         = ["drnicwilliams@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ecloud_cpi"
  gem.require_paths = ["lib"]
  gem.version       = EcloudCpi::VERSION
end
