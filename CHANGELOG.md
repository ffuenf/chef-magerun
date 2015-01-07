# CHANGELOG for magerun

This file is used to list changes made in each version of magerun.

## 2.1.2:

* update install command

## 2.1.1:

* add overwrite config and set root user warning default to false

## 2.1.0:

* update/integrate testsuites: test-kitchen, foodcritic, rubocop, travis-ci

## 2.0.3:

* fix db:drop --force command

## 2.0.2:

* add role attribute to admin:user:create

## 2.0.1:

* add sys:setup:incremental command

## 2.0.0:

* remove composer entirely as its not needed here
* move installation of magerun from LWRP to default recipe
* fix commands

## 1.1.0:

* remove dependency to chef-php-extra by including own composer lwrp
* add new magerun commands (v1.85.0)

## 1.0.0:

* Initial release of magerun