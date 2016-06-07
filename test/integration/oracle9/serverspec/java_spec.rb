require 'serverspec'

# Required by serverspec
set :backend, :exec

['oracle-java9-installer','oracle-java9-set-default'].each do |p|
  describe package(p), :if => ['debian', 'ubuntu'].include?(os[:family]) do
    it { should be_installed }
  end
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
  its(:stderr) { should match /Java HotSpot\(TM\) 64-Bit Server/ }
  its(:stderr) { should match /build 9-/ }
  its(:stderr) { should_not match /OpenJDK/ }
end
