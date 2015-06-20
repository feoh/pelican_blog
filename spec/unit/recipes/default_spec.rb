#
# Cookbook Name:: pelican_blog
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'pelican_blog::default' do

  before do
    stub_command('which nginx').and_return(nil)
  end

  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end
    it 'converges successfully' do
      chef_run # This should not raise an error
    end
    it 'installs nginx' do
      expect(chef_run).to install_package('nginx')
    end
    it 'installs git' do
      expect(chef_run).to install_package('git')
    end
  end
end
