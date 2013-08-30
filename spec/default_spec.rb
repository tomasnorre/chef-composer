require 'chefspec'

describe 'my_new_cookbook::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'composer::default' }
  it 'install composer globally' do
    expect(chef_run).to create_directory '/opt/composer'
  end
end