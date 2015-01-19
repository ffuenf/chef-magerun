require_relative '../../../kitchen/data/spec_helper'

describe file('/var/lib/n98-magerun') do
  it { should be_directory }
end

describe file('/usr/local/bin/n98-magerun') do
  it { should be_file }
  it { should be_executable }
end
