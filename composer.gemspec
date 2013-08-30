
Gem::Specification.new do |s|
  s.name = 'composer'
  s.version = '0.2.1'
  s.description = ''
  s.summary = "chefspec-#{s.version}"
  s.required_ruby_version = '>= 1.9'

  s.add_dependency 'chef',    '>= 10.0'
  s.add_dependency 'erubis'
  s.add_dependency 'fauxhai', '~> 1.1'
  s.add_dependency 'minitest-chef-handler', '>= 0.6.0'
  s.add_dependency 'rspec', '~> 2.0'

  # Development Dependencies
  s.add_development_dependency 'rake'
  s.add_development_dependency 'yard', '~> 0.8'
end