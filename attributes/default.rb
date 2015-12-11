# # # # # # # #
# n98-magerun #
# # # # # # # #
default['n98-magerun']['url'] = 'https://files.magerun.net/n98-magerun-latest.phar'
default['n98-magerun']['install_dir'] = '/usr/local/bin'
default['n98-magerun']['install_file'] = 'n98-magerun'
default['n98-magerun']['dir'] = '/var/lib/n98-magerun'
default['n98-magerun']['user'] = 'www-data'

default['n98-magerun']['magento_install']['user'] = 'www-data'
default['n98-magerun']['magento_install']['group'] = 'www-data'

default['n98-magerun']['modules']['home'] = '/usr/local/share/n98-magerun/modules'
default['n98-magerun']['modules']['repos'] = []

default['n98-magerun']['config']['application']['check-root-user'] = 'false'
