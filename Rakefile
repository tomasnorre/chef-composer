require 'bundler/gem_tasks'
require 'chefspec'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:unit) do |t|
  t.rspec_opts = [].tap do |a|
    a.push('--color')
    a.push('--format progress')
    a.push('--tag ~chef_11') unless ChefSpec.chef_11?
    a.push('--tag ~chef_10') unless ChefSpec.chef_10?
  end.join(' ')
end