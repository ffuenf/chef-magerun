chef-magerun
============
[![GitHub tag](http://img.shields.io/github/tag/ffuenf/chef-magerun.svg)][tag]
[![Build Status](http://img.shields.io/travis/ffuenf/chef-magerun.svg)][travis]
[![Gittip](http://img.shields.io/gittip/arosenhagen.svg)][gittip]

[tag]: https://github.com/ffuenf/chef-magerun/tags
[travis]: https://travis-ci.org/ffuenf/chef-magerun
[gittip]: https://www.gittip.com/arosenhagen

chef-magerun installs [n98-magerun](https://github.com/netz98/n98-magerun) and provides access to a corresponding LWRP.

Usage
-----

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

Dependencies
------------

This cookbook depends on the following community cookbooks.

* php

Recommendations
---------------

* dop_php

Platform
--------

The following platforms are supported and tested:

* Debian 6.x
* Debian 7.x
* Ubuntu 14.04.x

Other Debian family distributions are assumed to work.

Development
-----------
1. Fork the repository from GitHub.
2. Clone your fork to your local machine:

        $ git clone git@github.com:USER/chef-magerun.git

3. Create a git branch

        $ git checkout -b my_bug_fix

4. **Write tests**
5. Make your changes/patches/fixes, committing appropriately
6. Run the tests: `foodcritic`, `rubocop`, `kitchen test`
7. Push your changes to GitHub
8. Open a Pull Request

Testing
-------

chef-magerun is on [Travis CI](http://travis-ci.org/ffuenf/chef-magerun) which tests against multiple Chef and Ruby versions.

The following Rake tasks are provided for automated testing of the cookbook:

* `rake rubocop` - Run [RuboCop] style and lint checks
* `rake foodcritic` - Run [Foodcritic] lint checks
* `rake integration` - Run [Test Kitchen] integration tests (provisions a
  Vagrant VM using this cookbook and then tests the infrastructure with
  [Serverspec])
* `rake test` - Run all tests

License and Author
------------------

- Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)

- Copyright:: 2015, ffuenf

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
