require 'serverspec'

# Required by serverspec
set :backend, :exec

if ['debian', 'ubuntu'].include?(os[:family])

  describe package('openjdk-9-jdk') do
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

  describe file('/etc/alternatives/java') do
    it { should exist }
    it { should be_symlink }
    it { should be_linked_to '/usr/lib/jvm/java-9-openjdk-amd64/jre/bin/java' }
  end

elsif ['redhat', 'centos'].include?(os[:family])

  describe package('java-1.9.0-openjdk') do
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

  describe file('/etc/alternatives/java') do
    it { should exist }
    it { should be_symlink }
    it { should be_linked_to '/usr/lib/jvm/jre-1.9.0-openjdk.x86_64/bin/java' }
  end

end

describe command('/usr/bin/java -version') do
  let(:disable_sudo) { true }
  its(:stderr) { should match "OpenJDK 64-Bit Server VM" }
  its(:stderr) { should match /build 9-/ }
end
