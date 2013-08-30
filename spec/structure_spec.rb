require 'spec_helper'

describe 'composer::default' do
  let(:target_dir) { '/foo/bar/zip' }
  let(:runner) do
    runner = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04')
    runner.node.set['composer']['target_dir'] = target_dir
    runner.converge('composer::default')
  end

  it 'creates the target directory' do
    expect(runner).to create_directory(target_dir)
  end

  it 'is owned by the root user' do
    expect(runner.directory(target_dir)).to be_owned_by('root', 'root')
  end

  it 'has 0755 permissions' do
    expect(runner.directory(target_dir).mode).to eq('0755')
  end
end