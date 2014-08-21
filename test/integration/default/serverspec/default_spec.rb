require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe file('/var/lib/n98-magerun') do
  it { should be_directory }
end

describe file('/usr/local/bin/n98-magerun') do
  it { should be_file }
  it { should be_executable }
end
