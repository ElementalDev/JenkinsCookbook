# # encoding: utf-8

# Inspec test for recipe jenkins::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# This is an example test, replace it with your own test.

# Java 8 should be installed
describe package("openjdk-8-jdk") do
  it { should be_installed }
  its("version") { should match "8u181-b13-0ubuntu0.16.04.1" }
end

# The jenkins apt should have been added
describe apt("http://pkg.jenkins.io/debian-stable") do
  it { should exist }
  it { should be_enabled }
end

# Jenkins should be installed
describe package("jenkins") do
  it { should be_installed }
  its("version") { should match /2\.1/ }
end

# Jenkins should be running and enabled
describe service("jenkins") do
  it { should be_running }
  it { should be_enabled }
end
