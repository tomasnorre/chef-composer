require 'spec_helper'

describe 'composer::default' do
  let(:version)  { '1.0.0' }
  let(:owner)  { 'root' }
  let(:group)  { 'www-data' }

  let(:runner) {
    runner = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04')

    runner.converge('composer::default')
  }

  #it 'install composer globally' do
  #  expect(runner).to create_directory '/opt/composer'
  #end

  #it 'creates the symlink' do
  #  link = runner.link('composer')
  #  expect(link.target_file).to eq('/usr/local/bin/phantomjs')
  #  expect(link.to).to eq("/usr/local/#{basename}/bin/phantomjs")
  #end
end