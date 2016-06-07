require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('openjdk-7-jdk'), :if => ['debian', 'ubuntu'].include?(os[:family]) do
  it { should be_installed }
end

describe package('java-1.7.0-openjdk'), :if => ['redhat', 'centos'].include?(os[:family]) do
  it { should be_installed }
end

describe package('ca-certificates') do
  it { should be_installed }
end

describe file('/usr/bin/java') do
  it { should exist }
  it { should be_symlink }
  it { should be_linked_to '/etc/alternatives/java' }
end

describe command('/usr/bin/java -version') do
  let(:disable_sudo) { true }
  its(:stderr) { should match /OpenJDK 64-Bit Server VM/ }
  its(:stderr) { should match /version.*1\.7\.0/ }
end
