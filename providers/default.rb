#
# Cookbook Name:: magerun
# Provider:: magerun
#
# Copyright 2013, Achim Rosenhagen
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

# Support whyrun
def whyrun_supported?
	true
end

action :install do
	description = "Install magento in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' install'
		command << ' --dbHost="#{new_resource.dbHost}"'
		command << ' --dbUser="#{new_resource.dbUser}"' if !@new_resource.dbUser.empty?
		command << ' --dbPass="#{new_resource.dbPass}"' if !@new_resource.dbPass.empty?
		command << ' --dbName="#{new_resource.dbName}"' if !@new_resource.dbName.empty?
		command << ' --installSampleData="yes"' if @new_resource.installSampleData
		command << ' --useDefaultConfigParams="yes"' if @new_resource.useDefaultConfigParams
		command << ' --magentoVersionByName="#{new_resource.magentoVersionByName}"'
		command << ' --installationFolder="#{new_resource.installationFolder}"' if !@new_resource.installationFolder.empty?
		command << ' --baseUrl="#{new_resource.baseUrl}"' if !@new_resource.baseUrl.empty?
		
		magerun(command, description)
	end
end

action :script do
	description = "Run multiple n98-magerun commands in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' script #{new_resource.filename}'
		
		magerun(command, description)
	end
end

action :selfupdate do
	description = "Update n98-magerun.phar to the latest version in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' self-update'
		
		magerun(command, description)
	end
end

action :shell do
	description = "Run n98-magerun as shell in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' shell #{new_resource.command}'
		
		magerun(command, description)
	end
end

action :uninstall do
	description = "Uninstall magento (drop database and empties current folder) in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' uninstall'
		
		magerun(command, description)
	end
end

action :admin_notifications do
	description = "Toggle admin notifications in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' admin:notifications'
		
		magerun(command, description)
	end
end

action :admin_user_changepassword do
	description = "Change the password of a adminhtml user in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' admin:user:change-password #{@new_resource.username} #{@new_resource.password}'
		
		magerun(command, description)
	end
end

action :admin_user_create do
	description = "Create admin user in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' admin:user:create #{@new_resource.username} #{@new_resource.email} #{@new_resource.password} #{@new_resource.firstname} #{@new_resource.lastname}'
		
		magerun(command, description)
	end
end

action :admin_user_list do
	description = "List admin users in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' admin:user:list'
		
		magerun(command, description)
	end
end

action :cache_clean do
	description = "Clean magento cache in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' cache:clean #{@new_resource.cachekey}'
		
		magerun(command, description)
	end
end

action :cache_disable do
	description = "Disable magento caches in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' cache:disable'
		
		magerun(command, description)
	end
end

action :cache_enable do
	description = "Enable magento caches in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' cache:enable'
		
		magerun(command, description)
	end
end

action :cache_flush do
	description = "Flush magento cache storage in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' cache:flush'
		
		magerun(command, description)
	end
end

action :cache_list do
	description = "List all magento caches in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' cache:list'
		
		magerun(command, description)
	end
end

action :cms_banner_toggle do
	description = "Toggle a banner (Enterprise only) in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' cms:banner:toggle #{@new_resource.banner_id}'
		
		magerun(command, description)
	end
end

action :cms_page_publish do
	description = "Publish a CMS page revision (Enterprise only) in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' cms:page:publish #{@new_resource.page_id} #{@new_resource.revision_id}'
		
		magerun(command, description)
	end
end

action :config_dump do
	description = "Dump merged xml config in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' config:dump #{@new_resource.config_path}'
		
		magerun(command, description)
	end
end

action :config_get do
	description = "Get a core config item in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' config:get'
		command << ' --scope-id=#{@new_resource.scopeid}' if !@new_resource.scopeid.empty?
		command << ' --decrypt' if @new_resource.decrypt
		command << ' #{@new_resource.config_path}'
		
		magerun(command, description)
	end
end

action :config_search do
	description = "Search system configuration descriptions in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' config:search #{@new_resource.query}'
		
		magerun(command, description)
	end
end

action :config_set do
	description = "Set a core config item in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' config:set'
		command << ' --scope=#{@new_resource.scope}' if !@new_resource.scope.empty?
		command << ' --scope-id=#{@new_resource.scopeid}' if !@new_resource.scopeid.empty?
		command << ' --encrypt' if @new_resource.encrypt
		command << ' #{@new_resource.config_path}'
		command << ' #{@new_resource.config_value}'
		
		magerun(command, description)
	end
end

action :customer_changepassword do
	description = "Change the password of a customer in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' customer:change-password #{@new_resource.email} #{@new_resource.password} #{@new_resource.website}'
		
		magerun(command, description)
	end
end

action :customer_create do
	description = "Create a customer in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' customer:create #{@new_resource.email} #{@new_resource.password} #{@new_resource.firstname} #{@new_resource.lastname} #{@new_resource.website}'
		
		magerun(command, description)
	end
end

action :customer_create_dummy do
	description = "Create dummy customers in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' customer:create:dummy #{@new_resource.count} #{@new_resource.locale} #{@new_resource.website}'
		
		magerun(command, description)
	end
end

action :customer_info do
	description = "Show infos about a customer in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' customer:info #{@new_resource.email} #{@new_resource.website}'
		
		magerun(command, description)
	end
end

action :customer_list do
	description = "List customers in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' customer:list #{@new_resource.query}'
		
		magerun(command, description)
	end
end

action :db_console do
	description = "Open mysql client by database config from local.xml in #{@new_resource.path}"
	converge_by(description) do
		command = 'n98-magerun.phar'
		command << ' db:console'
		
		magerun(command, description)
	end
end

action :db_drop do
	description = "Drop current database in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " db:drop"
		
		magerun(command, description)
	end
end

action :db_dump do
	description = "Dump database with mysqldump cli client according to informations from local.xml in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " --add-time" if @new_resource.addtime and @new_resource.filename.empty?
		command << " --compression=#{@new_resource.compression}" if @new_resource.compression and !@new_resource.compression.empty?
		command << " --only-command" if @new_resource.onlycommand and !@new_resource.filename.empty?
		command << " --no-single-transaction" if @new_resource.nosingletransaction
		command << " --human-readable" if @new_resource.humanreadable
		command << " --stdout" if @new_resource.stdout
		command << " --strip=#{@new_resource.strip}" if @new_resource.strip and !@new_resource.strip.empty?
		command << " --force" if @new_resource.force
		
		magerun(command, description)
	end
end

action :db_import do
	description = "Import database with mysql cli client according to database defined in local.xml in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " --compression=#{@new_resource.compression}" if @new_resource.compression and !@new_resource.compression.empty?
		command << " --only-command" if @new_resource.onlycommand and !@new_resource.filename.empty?
		
		magerun(command, description)
	end
end

action :db_info do
	description = "Dump database informations in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " db:info"
		
		magerun(command, description)
	end
end

action :db_query do
	description = "Execute an SQL query on the database defined in local.xml in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " db:query"
		command << " --only-command" if @new_resource.onlycommand and !@new_resource.filename.empty?
		command << " #{@new_resource.query}"
		
		magerun(command, description)
	end
end

action :design_demonotice do
	description = "Toggle demo store notice for a store view in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " design:demonotice #{@new_resource.store}"
		
		magerun(command, description)
	end
end

action :dev_class_lookup do
	description = "Resolve a grouped class name in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:class:lookup #{@new_resource.class_type} #{@new_resource.class_name}"
		
		magerun(command, description)
	end
end

action :dev_console do
	description = "Open PHP interactive shell with initialized Mage::app() (Experimental) in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:console"
		
		magerun(command, description)
	end
end

action :dev_ide_phpstorm_meta do
	description = "Generate meta data file for PhpStorm auto completion in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:ide:phpstorm:meta"
		command << " --stdout" if @new_resource.stdout
		
		magerun(command, description)
	end
end

action :dev_log do
	description = "Toggle development log (system.log, exception.log) in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:log"
		command << " --#{@new_resource.status}" if !@new_resource.status.empty?
		command << " --global" if @new_resource.global
		command << " #{@new_resource.store}"
		
		magerun(command, description)
	end
end

action :dev_log_db do
	description = "Turn on/off database query logging in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:log:db"
		command << " --#{@new_resource.status}" if !@new_resource.status.empty?
		
		magerun(command, description)
	end
end

action :dev_log_size do
	description = "Get size of log file in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:log:size #{@new_resource.log_filename}"
		
		magerun(command, description)
	end
end

action :dev_module_create do
	description = "Create and register a new magento module in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:module:create"
		command << " --add-blocks" if @new_resource.addblocks
		command << " --add-helpers" if @new_resource.addhelpers
		command << " --add-models" if @new_resource.addmodels
		command << " --add-setup" if @new_resource.addsetup
		command << " --add-all" if @new_resource.addall
		command << " --modman" if @new_resource.modman
		command << " --add-readme" if @new_resource.addreadme
		command << " --add-composer" if @new_resource.addcomposer
		command << " --author-name='#{@new_resource.authorname}'" if !@new_resource.authorname.empty?
		command << " --author-email='#{@new_resource.authoremail}'" if !@new_resource.authoremail.empty?
		command << " --description='#{@new_resource.description}'" if !@new_resource.description.empty?
		command << " #{@new_resource.vendorNamespace}"
		command << " #{@new_resource.moduleName}"
		command << " #{@new_resource.codePool}"
		
		magerun(command, description)
	end
end

action :dev_module_list do
	description = "List all installed modules in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:module:list"
		
		magerun(command, description)
	end
end

action :dev_module_observer_list do
	description = "List all registered observers in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:module:observer:list"
		command << " #{@new_resource.observertype}"
		
		magerun(command, description)
	end
end

action :dev_module_rewrite_conflicts do
	description = "List all magento rewrite conflicts in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:module:rewrite:conflicts"
		command << " --log-junit='#{@new_resource.logjunit}'" if !@new_resource.logjunit.empty?
		
		magerun(command, description)
	end
end

action :dev_module_rewrite_list do
	description = "List all magento rewrites in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:module:rewrite:list"
		
		magerun(command, description)
	end
end

action :dev_profiler do
	description = "Toggle profiler for debugging in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:profiler"
		command << " --#{@new_resource.status}" if !@new_resource.status.empty?
		command << " --global" if @new_resource.global
		command << " #{@new_resource.store}"
		
		magerun(command, description)
	end
end

action :dev_report_count do
	description = "Get count of report files in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:report:count"
		
		magerun(command, description)
	end
end

action :dev_setup_script_attribute do
	description = "Create attribute script for a given attribute code in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:setup:script:attribute #{@new_resource.entityType} #{@new_resource.attributeCode}"
		
		magerun(command, description)
	end
end

action :dev_symlinks do
	description = "Toggle allow symlinks setting in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:symlinks"
		command << " --#{@new_resource.status}" if !@new_resource.status.empty?
		command << " --global" if @new_resource.global
		command << " #{@new_resource.store}"
		
		magerun(command, description)
	end
end

action :dev_templatehints do
	description = "Toggle template hints in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:template-hints #{@new_resource.store}"
		
		magerun(command, description)
	end
end

action :dev_templatehintsblocks do
	description = "Toggle template hints block names in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:template-hints-blocks #{@new_resource.store}"
		
		magerun(command, description)
	end
end

action :dev_theme_duplicates do
	description = "Find duplicate files in your theme in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:theme:duplicates"
		command << " --log-junit=#{@new_resource.logjunit}" if !@new_resource.logjunit.empty?
		command << " #{@new_resource.theme} #{@new_resource.originalTheme}"
		
		magerun(command, description)
	end
end

action :dev_theme_list do
	description = "List all available themes in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:theme:list"
		
		magerun(command, description)
	end
end

action :dev_translate_admin do
	description = "Toggle inline translation tool for admin in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:translate:admin"
		
		magerun(command, description)
	end
end

action :dev_translate_shop do
	description = "Toggle inline translation tool for shop in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " dev:translate:shop #{@new_resource.store}"
		
		magerun(command, description)
	end
end

action :extension_download do
	description = "Download magento-connect package in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " extension:download #{@new_resource.package_key}"
		
		magerun(command, description)
	end
end

action :extension_install do
	description = "Install magento-connect package in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " extension:install #{@new_resource.package_key}"
		
		magerun(command, description)
	end
end

action :extension_list do
	description = "List magento connection extensions in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " extension:list #{@new_resource.query}"
		
		magerun(command, description)
	end
end

action :extension_search do
	description = "List magento connection extensions in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " extension:search #{@new_resource.query}"
		
		magerun(command, description)
	end
end

action :extension_upgrade do
	description = "Upgrade magento-connect package in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " extension:upgrade #{@new_resource.package_key}"
		
		magerun(command, description)
	end
end

action :index_list do
	description = "List all magento indexes in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " index:list"
		
		magerun(command, description)
	end
end

action :index_reindex do
	description = "Reindex a magento index by code in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " index:reindex #{@new_resource.code}"
		
		magerun(command, description)
	end
end

action :index_reindex_all do
	description = "Reindex all magento indexes in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " index:reindex:all"
		
		magerun(command, description)
	end
end

action :localconfig_generate do
	description = "Generate local.xml config in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " local-config:generate"
		
		magerun(command, description)
	end
end

action :sys_check do
	description = "Check Magento System in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " sys:check"
		
		magerun(command, description)
	end
end

action :sys_cron_history do
	description = "List last executed jobs in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " sys:cron:history"
		
		magerun(command, description)
	end
end

action :sys_cron_list do
	description = "List all cronjobs in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " sys:cron:list"
		
		magerun(command, description)
	end
end

action :sys_cron_run do
	description = "Run a cronjob by job code in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " sys:cron:run #{@new_resource.job}"
		
		magerun(command, description)
	end
end

action :sys_info do
	description = "Print infos about the current magento system in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " sys:info"
		
		magerun(command, description)
	end
end

action :sys_maintenance do
	description = "Toggle maintenance mode in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " sys:maintenance"
		command << " --#{@new_resource.status}" if !@new_resource.status.empty?
		
		magerun(command, description)
	end
end

action :sys_modules_list do
	description = "List all installed modules in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " sys:modules:list"
		
		magerun(command, description)
	end
end

action :sys_setup_compareversions do
	description = "Compare module version with core_resource table in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " sys:setup:compare-versions"
		command << " --ignore-data" if @new_resource.ignoredata
		
		magerun(command, description)
	end
end

action :sys_setup_run do
	description = "Run all new setup scripts in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " sys:setup:run"
		
		magerun(command, description)
	end
end

action :sys_store_config_baseurl_list do
	description = "List all base urls in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " sys:store:config:base-url:list"
		
		magerun(command, description)
	end
end

action :sys_store_list do
	description = "List all installed store-views in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " sys:store:list"
		
		magerun(command, description)
	end
end

action :sys_url_list do
	description = "Get all urls in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " sys:url:list"
		command << " --add-categories" if @new_resource.addcategories
		command << " --add-products" if @new_resource.addproducts
		command << " --add-cmspages" if @new_resource.addcmspages
		command << " --add-all" if @new_resource.addall
		command << " #{@new_resource.stores} #{@new_resource.linetemplate}"
		
		magerun(command, description)
	end
end

action :sys_website_list do
	description = "List all websites in #{@new_resource.path}"
	converge_by(description) do
		command = "n98-magerun.phar"
		command << " sys:website:list"
		
		magerun(command, description)
	end
end

def magerun(command, description)
	script description do
		interpreter 'bash'
		cwd new_resource.path
		code <<-EOF
			#{command}
		EOF
	end
end
