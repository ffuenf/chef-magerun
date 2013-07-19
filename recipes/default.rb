# # # # # # # #
# n98-magerun #
# # # # # # # #

directory node['n98-magerun']['dir']
git node['n98-magerun']['dir'] do
	repository node['n98-magerun']['git-url']
	reference node['n98-magerun']['git-reference']
	action :sync
	not_if do
		::File.exists?("#{node['n98-magerun']['install_dir']}/#{node['n98-magerun']['install_file']}")
	end
end
chef_php_extra_composer node['n98-magerun']['dir'] do
	action [:install_composer, :install_packages]
end
bash 'install_n98-magerun' do
	cwd node['n98-magerun']['dir']
	code <<-EOF
		cp #{node['n98-magerun']['install_file']} #{node['n98-magerun']['install_dir']}
	EOF
	not_if do
		::File.exists?("#{node['n98-magerun']['install_dir']}/#{node['n98-magerun']['install_file']}")
	end
	creates "#{node['n98-magerun']['install_dir']}/#{node['n98-magerun']['install_file']}"
end
bash 'update_n98-magerun' do
	cwd ::File.dirname("#{Chef::Config['file_cache_path']}")
	code <<-EOH
		#{node['n98-magerun']['install_file']} self-update
	EOH
	only_if do
		::File.exists?("#{node['n98-magerun']['install_dir']}/#{node['n98-magerun']['install_file']}")
	end
end
