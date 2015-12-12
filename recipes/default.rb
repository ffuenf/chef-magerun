# # # # # # # #
# n98-magerun #
# # # # # # # #
include_recipe 'php'

directory node['n98-magerun']['dir']
remote_file "#{node['n98-magerun']['install_dir']}/#{node['n98-magerun']['install_file']}" do
  source node['n98-magerun']['url']
  use_last_modified true
  owner 'root'
  group 'root'
  mode 0755
end
template '/etc/n98-magerun.yaml' do
  source 'config.yaml.erb'
  variables(
    config: node['n98-magerun']['config']
  )
end
