# # # # # # # #
# n98-magerun #
# # # # # # # #
include_recipe 'php'
package 'wget'

directory node['n98-magerun']['dir']
execute 'install_n98-magerun' do
  cwd node['n98-magerun']['dir']
  command "wget #{node['n98-magerun']['url']} -O n98-magerun #{node['n98-magerun']['install_dir']}/#{node['n98-magerun']['install_file']}"
  not_if { ::File.exist?("#{node['n98-magerun']['install_dir']}/#{node['n98-magerun']['install_file']}") }
  creates "#{node['n98-magerun']['install_dir']}/#{node['n98-magerun']['install_file']}"
  action :run
  notifies :run, 'execute[make n98-magerun executable]'
end
execute 'make n98-magerun executable' do
  cwd node['n98-magerun']['dir']
  command "chmod +x #{node['n98-magerun']['install_dir']}/#{node['n98-magerun']['install_file']}"
  action :nothing
end
template '/etc/n98-magerun.yaml' do
  source 'config.yaml.erb'
  variables(
    config: node['n98-magerun']['config']
  )
end
