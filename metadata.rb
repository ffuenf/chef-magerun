maintainer       "Achim Rosenhagen"
maintainer_email "a.rosenhagen@ffuenf.de"
license          "Apache 2.0"
description      "installs/configures n98-magerun.phar"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "2.0.3"

%w{ debian ubuntu centos suse fedora redhat scientific amazon freebsd windows mac_os_x }.each do |os|
	supports os
end

%w{ php }.each do |ressource|
	depends ressource
end

%w{ dop_php }.each do |ressource|
	recommends ressource
end
