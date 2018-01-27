$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'p_hash'
  s.version     = '0.0.1'
  s.licenses    = ['MIT']
  s.summary     = "A gem that provides an implementation of p_hash"
  s.description = "This is a gem that provides an implementation of the p_hash function as described in the TLS specification"
  s.authors     = ["Jonathan Hooper"]
  s.email       = 'jon@jonathanhooper.net'
  s.files       = Dir.glob('lib/**/*') + ['LICENSE.md', 'README.md', 'Gemfile', 'p_hash.gemspec']
  s.homepage    = 'https://github.com/jmhooper/p_hash'

  s.add_development_dependency 'rspec'
end
