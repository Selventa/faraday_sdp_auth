# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faraday_sdp_auth/version'

Gem::Specification.new do |spec|
  spec.name          = "faraday_sdp_auth"
  spec.version       = FaradaySdpAuth::VERSION
  spec.authors       = ["Anthony Bargnesi"]
  spec.email         = ["abargnesi@selventa.com"]

  spec.summary       = %q{Authenticate SDP URLs with Faraday.}
  spec.description   = %q{This provides middlware for Faraday to authenticate SDP URLs with api and private keys.}
  spec.homepage      = "https://github.com/Selventa/faraday_sdp_auth"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency  "faraday", "~> 0.9"
end
