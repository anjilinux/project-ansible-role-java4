require 'serverspec'

# Required by serverspec
set :backend, :exec

if ['debian', 'ubuntu'].include?(os[:family])

  describe package('oracle-java8-installer') do
    it { should be_installed }
  end

  describe package('oracle-java8-set-default') do
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
    it { should be_linked_to '/usr/lib/jvm/java-8-oracle/jre/bin/java' }
  end

elsif ['redhat', 'centos'].include?(os[:family])

  # describe package('oracle-java8-installer') do
  #   it { should be_installed }
  # end
  #
  # describe package('oracle-java8-set-default') do
  #   it { should be_installed }
  # end
  #
  # describe file('/usr/bin/java') do
  #   it { should exist }
  # end

end

describe command('/usr/bin/java -version') do
  let(:disable_sudo) { true }
  its(:stderr) { should match "Java HotSpot(TM) 64-Bit Server" }
  its(:stderr) { should match /build 1.8.0/ }
  its(:stderr) { should_not match "OpenJDK" }
end
