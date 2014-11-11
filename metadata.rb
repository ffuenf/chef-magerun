maintainer 'Achim Rosenhagen'
maintainer_email 'a.rosenhagen@ffuenf.de'
license 'Apache 2.0'
description 'installs/configures n98-magerun.phar'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
name 'magerun'
version '2.1.1'

%w(debian ubuntu).each do |os|
  supports os
end

%w(php).each do |ressource|
  depends ressource
end
