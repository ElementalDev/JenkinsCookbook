#
# Cookbook:: jenkins
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'jenkins::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it "should update all resources" do
      expect(chef_run).to update_apt_update("update")
    end

    it "should update all resources with jenkins" do
      expect(chef_run).to update_apt_update("update_with_jenkins")
    end

    it "should install java 8" do
      expect(chef_run).to install_package("openjdk-8-jdk")
    end

    it "should add key using bash" do
      expect(chef_run).to run_bash("cd /tmp && wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -s")
    end

    it "should add jenkins to the sources list" do
      expect(chef_run).to add_apt_repository("add_jenkins")
    end

    it "should install jenkins" do
      expect(chef_run).to install_package("jenkins")
    end

    it "should start and enable jenkins" do
      expect(chef_run).to start_service("jenkins")
      expect(chef_run).to enable_service("jenkins")
    end
  end
end
