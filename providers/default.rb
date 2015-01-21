#
# Cookbook Name:: magerun
# Provider:: magerun
#
# Copyright 2014, Achim Rosenhagen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

def whyrun_supported?
  true
end

use_inline_resources

action :install_magento do
  description = "Install magento in #{@new_resource.path}"
  converge_by(description) do
    if php_ext?
      command = 'install'
      command << " --dbHost='#{new_resource.dbHost}'"
      command << " --dbUser='#{new_resource.dbUser}'"
      command << " --dbPass='#{new_resource.dbPass}'"
      command << " --dbName='#{new_resource.dbName}'"
      command << " --dbPort='#{new_resource.dbPort}'"
      command << " --installSampleData='no'" unless @new_resource.installSampleData
      command << " --useDefaultConfigParams='yes'" if @new_resource.useDefaultConfigParams
      command << " --magentoVersion='#{new_resource.magentoVersion}'"
      command << " --magentoVersionByName='#{new_resource.magentoVersionByName}'"
      command << " --installationFolder='#{new_resource.installationFolder}'" unless @new_resource.installationFolder.empty?
      command << " --baseUrl='#{new_resource.baseUrl}'" unless @new_resource.baseUrl.empty?
      command << ' --noDownload' if @new_resource.noDownload
      command << ' --replaceHtaccessFile' if @new_resource.replaceHtaccessFile
      command << ' --forceUseDb=true' if @new_resource.forceUseDb
      magerun(command, description)
    end
  end
end

action :set_permissions do
  description = "n98-magerun: Set rights and permissions of #{new_resource.installationFolder}"
  converge_by(description) do
    execute "set rights of #{new_resource.installationFolder}" do
      cwd new_resource.installationFolder
      command "chown #{node['n98-magerun']['magento_install']['user']}:#{node['n98-magerun']['magento_install']['group']} #{new_resource.installationFolder} -R"
      action :run
    end
    execute "set file permissions of #{new_resource.installationFolder}" do
      cwd new_resource.installationFolder
      command 'find . -type f -exec chmod 644 {} \;'
      action :run
    end
    execute "set folder permissions of #{new_resource.installationFolder}" do
      cwd new_resource.installationFolder
      command 'find . -type d -exec chmod 755 {} \;'
      action :run
    end
  end
end

action :install_n98_module do
  description = "Install n98-magerun module #{new_resource.n98_module_name} in #{@new_resource.path}"
  converge_by(description) do
    directory node['n98-magerun']['modules']['home'] do
      recursive true
    end
    git "#{node['n98-magerun']['modules']['home']}/#{new_resource.n98_module_name}" do
      repository new_resource.n98_module_repo
      action :sync
    end
  end
end

action :selfupdate do
  description = "Update n98-magerun.phar to the latest version in #{@new_resource.path}"
  converge_by(description) do
    command = 'self-update'
    magerun(command, description)
  end
end

action :shell do
  description = "Run n98-magerun as shell in #{@new_resource.path}"
  converge_by(description) do
    command = "shell #{new_resource.command}"
    magerun(command, description)
  end
end

action :uninstall do
  description = "Uninstall magento (drop database and empties current folder) in #{@new_resource.path}"
  converge_by(description) do
    command = 'uninstall'
    magerun(command, description)
  end
end

action :admin_notifications do
  description = "Toggle admin notifications in #{@new_resource.path}"
  converge_by(description) do
    command = 'admin:notifications'
    magerun(command, description)
  end
end

action :admin_user_changepassword do
  description = "Change the password of a adminhtml user in #{@new_resource.path}"
  converge_by(description) do
    command = "admin:user:change-password #{@new_resource.username} #{@new_resource.password}"
    magerun(command, description)
  end
end

action :admin_user_create do
  description = "Create admin user in #{@new_resource.path}"
  converge_by(description) do
    command = "admin:user:create #{@new_resource.username} #{@new_resource.email} #{@new_resource.password} #{@new_resource.firstname} #{@new_resource.lastname} #{@new_resource.role}"
    magerun(command, description)
  end
end

action :admin_user_list do
  description = "List admin users in #{@new_resource.path}"
  converge_by(description) do
    command = 'admin:user:list'
    magerun(command, description)
  end
end

action :cache_clean do
  description = "Clean magento cache in #{@new_resource.path}"
  converge_by(description) do
    command = "cache:clean #{@new_resource.cachekey}"
    magerun(command, description)
  end
end

action :cache_disable do
  description = "Disable magento caches in #{@new_resource.path}"
  converge_by(description) do
    command = 'cache:disable'
    magerun(command, description)
  end
end

action :cache_enable do
  description = "Enable magento caches in #{@new_resource.path}"
  converge_by(description) do
    command = 'cache:enable'
    magerun(command, description)
  end
end

action :cache_flush do
  description = "Flush magento cache storage in #{@new_resource.path}"
  converge_by(description) do
    command = 'cache:flush'
    magerun(command, description)
  end
end

action :cache_list do
  description = "List all magento caches in #{@new_resource.path}"
  converge_by(description) do
    command = 'cache:list'
    magerun(command, description)
  end
end

action :cache_report do
  description = "View inside the cache in #{@new_resource.path}"
  converge_by(description) do
    command = 'cache:report'
    magerun(command, description)
  end
end

action :cache_view do
  description = "Prints a cache entry in #{@new_resource.path}"
  converge_by(description) do
    command = "cache:view #{@new_resource.id}"
    command << ' --unserialize' if @new_resource.unserialize
    command << ' --fpc' if @new_resource.fpc
    command << " #{@new_resource.id}"
    magerun(command, description)
  end
end

action :composer_diagnose do
  description = "Diagnoses the system to identify common errors in #{@new_resource.path}"
  converge_by(description) do
    command = 'composer:diagnose'
    magerun(command, description)
  end
end

action :composer_init do
  description = "Creates a basic composer.json file in current directory in #{@new_resource.path}"
  converge_by(description) do
    command = 'composer:init'
    magerun(command, description)
  end
end

action :composer_install do
  description = "Installs the project dependencies from the composer.lock file if present, or falls back on the composer.json in #{@new_resource.path}"
  converge_by(description) do
    command = 'composer:install'
    magerun(command, description)
  end
end

action :composer_require do
  description = "Adds required packages to your composer.json and installs them in #{@new_resource.path}"
  converge_by(description) do
    command = 'composer:require'
    magerun(command, description)
  end
end

action :composer_search do
  description = "Search for packages in #{@new_resource.path}"
  converge_by(description) do
    command = 'composer:search'
    magerun(command, description)
  end
end

action :composer_update do
  description = "Updates your dependencies to the latest version according to composer.json, and updates the composer.lock file in #{@new_resource.path}"
  converge_by(description) do
    command = 'composer:update'
    magerun(command, description)
  end
end

action :composer_validate do
  description = "Validates a composer.json in #{@new_resource.path}"
  converge_by(description) do
    command = 'composer:validate'
    magerun(command, description)
  end
end

action :config_dump do
  description = "Dump merged xml config in #{@new_resource.path}"
  converge_by(description) do
    command = 'config:dump'
    magerun(command, description)
  end
end

action :config_get do
  description = "Get a core config item in #{@new_resource.path}"
  converge_by(description) do
    command = 'config:get'
    command << " --scope-id=#{@new_resource.scopeid}"
    command << ' --decrypt' if @new_resource.decrypt
    command << " #{@new_resource.config_path}"
    magerun(command, description)
  end
end

action :config_search do
  description = "Search system configuration descriptions in #{@new_resource.path}"
  converge_by(description) do
    command = "config:search #{@new_resource.query}"
    magerun(command, description)
  end
end

action :config_set do
  description = "Set a core config item in #{@new_resource.path}"
  converge_by(description) do
    command = 'config:set'
    command << " --scope=#{@new_resource.scope}"
    command << " --scope-id=#{@new_resource.scopeid}"
    command << ' --encrypt' if @new_resource.encrypt
    command << " #{@new_resource.config_path}"
    command << " #{@new_resource.config_value}"
    magerun(command, description)
  end
end

action :customer_changepassword do
  description = "Change the password of a customer in #{@new_resource.path}"
  converge_by(description) do
    command = "customer:change-password #{@new_resource.email} #{@new_resource.password} #{@new_resource.website}"
    magerun(command, description)
  end
end

action :customer_create do
  description = "Create a customer in #{@new_resource.path}"
  converge_by(description) do
    command = "customer:create #{@new_resource.email} #{@new_resource.password} #{@new_resource.firstname} #{@new_resource.lastname} #{@new_resource.website}"
    magerun(command, description)
  end
end

action :customer_create_dummy do
  description = "Create dummy customers in #{@new_resource.path}"
  converge_by(description) do
    command = "customer:create:dummy #{@new_resource.count} #{@new_resource.locale} #{@new_resource.website}"
    magerun(command, description)
  end
end

action :customer_info do
  description = "Show infos about a customer in #{@new_resource.path}"
  converge_by(description) do
    command = "customer:info #{@new_resource.email} #{@new_resource.website}"
    magerun(command, description)
  end
end

action :customer_list do
  description = "List customers in #{@new_resource.path}"
  converge_by(description) do
    command = "customer:list #{@new_resource.query}"
    magerun(command, description)
  end
end

action :db_console do
  description = "Open mysql client by database config from local.xml in #{@new_resource.path}"
  converge_by(description) do
    command = 'db:console'
    magerun(command, description)
  end
end

action :db_create do
  description = "Create currently configured database in #{@new_resource.path}"
  converge_by(description) do
    command = 'db:create'
    magerun(command, description)
  end
end

action :db_drop do
  description = "Drop current database in #{@new_resource.path}"
  converge_by(description) do
    command = 'db:drop'
    command << ' --force' if @new_resource.force
    magerun(command, description)
  end
end

action :db_dump do
  description = "Dump database with mysqldump cli client according to informations from local.xml to #{@new_resource.path}"
  converge_by(description) do
    command = 'db:dump'
    command << '--add-time' if @new_resource.addtime && @new_resource.filename.empty?
    command << " --compression='#{@new_resource.compression}'" if @new_resource.compression && !@new_resource.compression.empty?
    command << ' --only-command' if @new_resource.onlycommand && !@new_resource.filename.empty?
    command << ' --no-single-transaction' if @new_resource.nosingletransaction
    command << ' --human-readable' if @new_resource.humanreadable
    command << ' --stdout' if @new_resource.stdout
    command << " --strip='#{@new_resource.strip}'" if @new_resource.strip && !@new_resource.strip.empty?
    command << ' --force' if @new_resource.force
    command << " #{@new_resource.filename}"
    magerun(command, description)
  end
end

action :db_import do
  description = "Import database file #{@new_resource.path} with mysql cli client according to database defined in local.xml"
  converge_by(description) do
    command = 'db:import'
    command << " --compression='#{@new_resource.compression}'" if @new_resource.compression && !@new_resource.compression.empty?
    command << ' --only-command' if @new_resource.onlycommand && @new_resource.filename.empty?
    command << " #{@new_resource.filename}"
    magerun(command, description)
  end
end

action :db_info do
  description = "Dump database informations in #{@new_resource.path}"
  converge_by(description) do
    command = 'db:info'
    magerun(command, description)
  end
end

action :db_query do
  description = "Execute an SQL query on the database defined in local.xml in #{@new_resource.path}"
  converge_by(description) do
    command = 'db:query'
    command << ' --only-command' if @new_resource.onlycommand && !@new_resource.filename.empty?
    command << " #{@new_resource.query}"
    magerun(command, description)
  end
end

action :design_demonotice do
  description = "Toggle demo store notice for a store view in #{@new_resource.path}"
  converge_by(description) do
    command = "design:demonotice #{@new_resource.store}"
    magerun(command, description)
  end
end

action :dev_class_lookup do
  description = "Resolve a grouped class name in #{@new_resource.path}"
  converge_by(description) do
    command = "dev:class:lookup #{@new_resource.class_type} #{@new_resource.class_name}"
    magerun(command, description)
  end
end

action :dev_console do
  description = "Open PHP interactive shell with initialized Mage::app() (Experimental) in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:console'
    magerun(command, description)
  end
end

action :dev_ide_phpstorm_meta do
  description = "Generate meta data file for PhpStorm auto completion in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:ide:phpstorm:meta'
    command << ' --stdout' if @new_resource.stdout
    magerun(command, description)
  end
end

action :dev_log do
  description = "Toggle development log (system.log, exception.log) in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:log'
    command << " --#{@new_resource.status}" unless @new_resource.status.empty?
    command << ' --global' if @new_resource.global
    command << " #{@new_resource.store}"
    magerun(command, description)
  end
end

action :dev_log_db do
  description = "Turn on/off database query logging in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:log:db'
    command << " --#{@new_resource.status}" unless @new_resource.status.empty?
    magerun(command, description)
  end
end

action :dev_log_size do
  description = "Get size of log file in #{@new_resource.path}"
  converge_by(description) do
    command = "dev:log:size #{@new_resource.log_filename}"
    magerun(command, description)
  end
end

action :dev_module_create do
  description = "Create and register a new magento module in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:module:create'
    command << ' --add-blocks' if @new_resource.addblocks
    command << ' --add-helpers' if @new_resource.addhelpers
    command << ' --add-models' if @new_resource.addmodels
    command << ' --add-setup' if @new_resource.addsetup
    command << ' --add-all' if @new_resource.addall
    command << ' --modman' if @new_resource.modman
    command << ' --add-readme' if @new_resource.addreadme
    command << ' --add-composer' if @new_resource.addcomposer
    command << " --author-name='#{@new_resource.authorname}'" unless @new_resource.authorname.empty?
    command << " --author-email='#{@new_resource.authoremail}'" unless @new_resource.authoremail.empty?
    command << " --description='#{@new_resource.description}'" unless @new_resource.description.empty?
    command << " #{@new_resource.vendorNamespace}"
    command << " #{@new_resource.moduleName}"
    command << " #{@new_resource.codePool}"
    magerun(command, description)
  end
end

action :dev_module_dependencies_from do
  description = "Show list of modules which depend on %s module in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:module:dependencies:from'
    command << ' --all' if @new_resource.all
    command << " --format='#{@new_resource.format}'" unless @new_resource.format.empty?
    command << " #{@new_resource.moduleName}"
    magerun(command, description)
  end
end

action :dev_module_dependencies_on do
  description = "Show list of modules which given module depends on #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:module:dependencies:on'
    command << ' --all' if @new_resource.all
    command << " --format='#{@new_resource.format}'" unless @new_resource.format.empty?
    command << " #{@new_resource.moduleName}"
    magerun(command, description)
  end
end

action :dev_module_list do
  description = "List all installed modules in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:module:list'
    magerun(command, description)
  end
end

action :dev_module_observer_list do
  description = "List all registered observers in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:module:observer:list'
    command << " #{@new_resource.observertype}"
    magerun(command, description)
  end
end

action :dev_module_rewrite_conflicts do
  description = "List all magento rewrite conflicts in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:module:rewrite:conflicts'
    command << " --log-junit='#{@new_resource.logjunit}'" unless @new_resource.logjunit.empty?
    magerun(command, description)
  end
end

action :dev_module_rewrite_list do
  description = "List all magento rewrites in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:module:rewrite:list'
    magerun(command, description)
  end
end

action :dev_profiler do
  description = "Toggle profiler for debugging in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:profiler'
    command << " --#{@new_resource.status}" unless @new_resource.status.empty?
    command << ' --global' if @new_resource.global
    command << " #{@new_resource.store}"
    magerun(command, description)
  end
end

action :dev_report_count do
  description = "Get count of report files in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:report:count'
    magerun(command, description)
  end
end

action :dev_setup_script_attribute do
  description = "Create attribute script for a given attribute code in #{@new_resource.path}"
  converge_by(description) do
    command = "dev:setup:script:attribute #{@new_resource.entityType} #{@new_resource.attributeCode}"
    magerun(command, description)
  end
end

action :dev_templatehints do
  description = "Toggle template hints in #{@new_resource.path}"
  converge_by(description) do
    command = "dev:template-hints #{@new_resource.store}"
    magerun(command, description)
  end
end

action :dev_templatehintsblocks do
  description = "Toggle template hints block names in #{@new_resource.path}"
  converge_by(description) do
    command = "dev:template-hints-blocks #{@new_resource.store}"
    magerun(command, description)
  end
end

action :dev_theme_duplicates do
  description = "Find duplicate files in your theme in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:theme:duplicates'
    command << " --log-junit=#{@new_resource.logjunit}" unless @new_resource.logjunit.empty?
    command << " #{@new_resource.theme} #{@new_resource.originalTheme}"
    magerun(command, description)
  end
end

action :dev_theme_list do
  description = "List all available themes in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:theme:list'
    magerun(command, description)
  end
end

action :dev_translate_admin do
  description = "Toggle inline translation tool for admin in #{@new_resource.path}"
  converge_by(description) do
    command = 'dev:translate:admin'
    magerun(command, description)
  end
end

action :dev_translate_shop do
  description = "Toggle inline translation tool for shop in #{@new_resource.path}"
  converge_by(description) do
    command = "dev:translate:shop #{@new_resource.store}"
    magerun(command, description)
  end
end

action :extension_download do
  description = "Download magento-connect package in #{@new_resource.path}"
  converge_by(description) do
    command = "extension:download #{@new_resource.package_key}"
    magerun(command, description)
  end
end

action :extension_install do
  description = "Install magento-connect package in #{@new_resource.path}"
  converge_by(description) do
    command = "extension:install #{@new_resource.package_key}"
    magerun(command, description)
  end
end

action :extension_list do
  description = "List magento connection extensions in #{@new_resource.path}"
  converge_by(description) do
    command = "extension:list #{@new_resource.query}"
    magerun(command, description)
  end
end

action :extension_search do
  description = "List magento connection extensions in #{@new_resource.path}"
  converge_by(description) do
    command = "extension:search #{@new_resource.query}"
    magerun(command, description)
  end
end

action :extension_upgrade do
  description = "Upgrade magento-connect package in #{@new_resource.path}"
  converge_by(description) do
    command = "extension:upgrade #{@new_resource.package_key}"
    magerun(command, description)
  end
end

action :index_list do
  description = "List all magento indexes in #{@new_resource.path}"
  converge_by(description) do
    command = 'index:list'
    magerun(command, description)
  end
end

action :index_reindex do
  description = "Reindex a magento index by code in #{@new_resource.path}"
  converge_by(description) do
    command = "index:reindex #{@new_resource.code}"
    magerun(command, description)
  end
end

action :index_reindex_all do
  description = "Reindex all magento indexes in #{@new_resource.path}"
  converge_by(description) do
    command = 'index:reindex:all'
    magerun(command, description)
  end
end

action :localconfig_generate do
  description = "Generate local.xml config in #{@new_resource.path}"
  converge_by(description) do
    command = 'local-config:generate'
    magerun(command, description)
  end
end

action :script do
  description = "Run multiple n98-magerun commands in #{@new_resource.path}"
  converge_by(description) do
    command = "script < #{new_resource.filename}"
    magerun(command, description)
  end
end

action :script_repo_list do
  description = "Lists all scripts in repository in #{@new_resource.path}"
  converge_by(description) do
    command = 'script:repo:list'
    magerun(command, description)
  end
end

action :script_repo_run do
  description = "Run script from repository in #{@new_resource.path}"
  converge_by(description) do
    command = 'script:repo:run'
    command << " --define='#{@new_resource.define}'" unless @new_resource.define.empty?
    command << ' --stop-on-error' if @new_resource.stop_on_error
    command << " #{@new_resource.script}"
    magerun(command, description)
  end
end

action :sys_check do
  description = "Check Magento System in #{@new_resource.path}"
  converge_by(description) do
    command = 'sys:check'
    magerun(command, description)
  end
end

action :sys_cron_history do
  description = "List last executed jobs in #{@new_resource.path}"
  converge_by(description) do
    command = 'sys:cron:history'
    magerun(command, description)
  end
end

action :sys_cron_list do
  description = "List all cronjobs in #{@new_resource.path}"
  converge_by(description) do
    command = 'sys:cron:list'
    magerun(command, description)
  end
end

action :sys_cron_run do
  description = "Run a cronjob by job code in #{@new_resource.path}"
  converge_by(description) do
    command = "sys:cron:run #{@new_resource.job}"
    magerun(command, description)
  end
end

action :sys_info do
  description = "Print infos about the current magento system in #{@new_resource.path}"
  converge_by(description) do
    command = 'sys:info'
    magerun(command, description)
  end
end

action :sys_maintenance do
  description = "Toggle maintenance mode in #{@new_resource.path}"
  converge_by(description) do
    command = 'sys:maintenance'
    command << " --#{@new_resource.status}" unless @new_resource.status.empty?
    magerun(command, description)
  end
end

action :sys_modules_list do
  description = "List all installed modules in #{@new_resource.path}"
  converge_by(description) do
    command = 'sys:modules:list'
    magerun(command, description)
  end
end

action :sys_setup_compareversions do
  description = "Compare module version with core_resource table in #{@new_resource.path}"
  converge_by(description) do
    command = 'sys:setup:compare-versions'
    command << ' --ignore-data' if @new_resource.ignoredata
    magerun(command, description)
  end
end

action :sys_setup_run do
  description = "Run all new setup scripts in #{@new_resource.path}"
  converge_by(description) do
    command = 'sys:setup:run'
    magerun(command, description)
  end
end

action :sys_setup_incremental do
  description = "Run all new setup scripts incrementally in #{@new_resource.path}"
  converge_by(description) do
    command = 'sys:setup:incremental'
    magerun(command, description)
  end
end

action :sys_store_config_baseurl_list do
  description = "List all base urls in #{@new_resource.path}"
  converge_by(description) do
    command = 'sys:store:config:base-url:list'
    magerun(command, description)
  end
end

action :sys_store_list do
  description = "List all installed store-views in #{@new_resource.path}"
  converge_by(description) do
    command = 'sys:store:list'
    magerun(command, description)
  end
end

action :sys_url_list do
  description = "Get all urls in #{@new_resource.path}"
  converge_by(description) do
    command = 'sys:url:list'
    command << ' --add-categories' if @new_resource.addcategories
    command << ' --add-products' if @new_resource.addproducts
    command << ' --add-cmspages' if @new_resource.addcmspages
    command << ' --add-all' if @new_resource.addall
    command << " #{@new_resource.stores} #{@new_resource.linetemplate}"
    magerun(command, description)
  end
end

action :sys_website_list do
  description = "List all websites in #{@new_resource.path}"
  converge_by(description) do
    command = 'sys:website:list'
    magerun(command, description)
  end
end

def magerun(command, description)
  command << ' -q' if @new_resource.quietMode
  command << ' -v' if @new_resource.verboseMode
  command << ' -vvv' if @new_resource.debugMode

  execute "n98-magerun: #{description}" do
    cwd new_resource.path
    user node['n98-magerun']['user']
    group node['n98-magerun']['group']
    command "#{node['n98-magerun']['install_dir']}/#{node['n98-magerun']['install_file']} -n --root-dir=#{new_resource.path} #{command}"
    action :run
  end
  new_resource.updated_by_last_action(true)
end

def php_ext?
  php_exts = %w(curl dom gd hash iconv mcrypt pcre pdo pdo_mysql simplexml)
  php_exts.each do |php_ext|
    cmdstr = "php -m | grep -qi #{php_ext}"
    cmd = Mixlib::ShellOut.new(cmdstr)
    cmd.run_command
    begin
      cmd.error!
      true
    rescue
      raise "n98-magerun: required PHP Extension #{php_ext} is missing!"
    end
  end
end
