# Copyright (c) 2009-2012 VMware, Inc.

require File.expand_path('../lib/cloud/ecloud/version', __FILE__)

Gem::Specification.new do |s|
  s.description   = %q{BOSH CPI for Terremark ECloud}
  s.summary       = s.description
  s.author        = "VMware"
  s.email         = "support@vmware.com"
  s.homepage      = "http://www.vmware.com"

  s.files         = `git ls-files`.split("\n")
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.name          = "ecloud_cpi"
  s.require_paths = ["lib"]
  s.version       = EcloudCpi::VERSION

  s.add_dependency "bosh_common", ">=0.4.0"
  s.add_dependency "bosh_cpi", ">=0.4.2"
  s.add_dependency "httpclient", ">=2.2.0"
  s.add_dependency "uuidtools", ">=2.1.2"
  s.add_dependency "yajl-ruby", ">=0.8.2"
  s.add_dependency "fog", "~> 1.3.1"
end
