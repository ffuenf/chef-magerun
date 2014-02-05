Description
===========

Installs [n98-magerun](https://github.com/netz98/n98-magerun) and provides access to a corresponding LWRP.

Requirements
============

This Cookbook is only useful when dealing with [magento](http://www.magentocommerce.com/). Therefore you must have a complete magento installation running to use this cookbook and its associated LWRP.

Cookbooks
---------

Attributes
==========

* `node['n98-magerun']['url']` - default: 'https://raw.github.com/netz98/n98-magerun/master/n98-magerun.phar'
* `node['n98-magerun']['install_dir']` - default: '/usr/local/bin'
* `node['n98-magerun']['install_file']` - default: 'n98-magerun.phar'
* `node['n98-magerun']['dir']` - default: '/var/lib/n98-magerun'
* `node['n98-magerun']['git-url']` - default: 'https://github.com/netz98/n98-magerun'
* `node['n98-magerun']['git-reference']` - default: 'master'

Usage
=====

Simply include the recipe in your application recipe, where you setup/deploy magento.
```ruby
include_recipe "magerun"
```

ATTENTION: name this cookbook "magerun" if you want to use the LWRP like this:
```ruby
magerun "PATH TO YOUR MAGENTO ROOT" do
	action :cache_flush
end
```

See [Command-Reference](https://github.com/netz98/n98-magerun/wiki/Command-Reference) for available commands.
Keep an eye on the associated actions in the LWRP (providers/default.rb) since some commands had to be rewritten using no "-".

As a sidenote for [vagrant](http://www.vagrantup.com) users: - You may set up a bash function to use a pseudo-tty with magerun in the vagrant box.

e.g. in your local `~/.bash_profile` place:
```bash
magerun () {
  vagrant ssh -- -t n98-magerun.phar --root-dir=/vagrant $@
}
```

Open a new bash prompt at your Vagrant project and interact with n98-magerun as if it were local.
```
$ magerun help
$ magerun cache:clean
```

Your commands will be run inside the Vagrant box using the n98-magerun config and Magento root defined.
For performance reasons you might like to use the `$ magerun shell` feature rather than opening a new ssh connection for each command.

License and Author
==================
parts of this cookbook has been copied from [rjocoleman](https://github.com/rjocoleman/magerun-chef)

Author of n98-magerun:: [netz98 new media GmbH](http://www.netz98.de)
Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)

Copyright:: 2014, Achim Rosenhagen

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.