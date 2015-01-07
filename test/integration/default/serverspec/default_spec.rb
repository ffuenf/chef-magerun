require 'serverspec'
set :backend, :exec
set :path, '/sbin:/usr/sbin:/usr/local/sbin:$PATH'

describe file('/var/lib/n98-magerun') do
  it { should be_directory }
end

describe file('/usr/local/bin/n98-magerun') do
  it { should be_file }
  it { should be_executable }
end
