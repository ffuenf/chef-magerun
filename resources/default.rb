actions :install_magento, :set_permissions, :install_n98_module, :script, :selfupdate, :shell, :uninstall, :admin_notifications, :admin_user_change_password, :admin_user_create, :admin_user_list, :cache_clean, :cache_disable, :cache_enable, :cache_flush, :cache_list, :cache_report, :cache_view, :composer_diagnose, :composer_init, :composer_install, :composer_require, :composer_search, :composer_update, :composer_validate, :config_delete, :config_dump, :config_get, :config_search, :config_set, :customer_change_password, :customer_create, :customer_create_dummy, :customer_info, :customer_list, :db_console, :db_create, :db_drop, :db_dump, :db_import, :db_info, :db_query, :design_demo_notice, :dev_class_lookup, :dev_console, :dev_ide_phpstorm_meta, :dev_log, :dev_log_db, :dev_log_size, :dev_module_create, :dev_module_dependencies_from, :dev_module_dependencies_on, :dev_module_list, :dev_module_observer_list, :dev_module_rewrite_conflicts, :dev_module_rewrite_list, :dev_profiler, :dev_report_count, :dev_setup_script_attribute, :dev_symlinks, :dev_template_hints, :dev_template_hints_blocks, :dev_theme_duplicates, :dev_theme_list, :dev_translate_admin, :dev_translate_shop, :extension_download, :extension_install, :extension_list, :extension_search, :extension_upgrade, :index_list, :index_reindex, :index_reindex_all, :local_config_generate, :script_repo_list, :script_repo_run, :sys_check, :sys_cron_history, :sys_cron_list, :sys_cron_run, :sys_info, :sys_maintenance, :sys_modules_list, :sys_setup_compare_versions, :sys_setup_incremental, :sys_setup_run, :sys_store_config_base_url_list, :sys_store_list, :sys_url_list, :sys_website_list
default_action :selfupdate

attribute :path, kind_of: String, name_attribute: true
attribute :magentoVersion, kind_of: String
attribute :magentoVersionByName, kind_of: String, default: 'magento-ce-1.9.1.0'
attribute :installationFolder, kind_of: String
attribute :dbHost, kind_of: String, default: 'localhost'
attribute :dbUser, kind_of: String
attribute :dbPass, kind_of: String
attribute :dbName, kind_of: String
attribute :dbPort, kind_of: Fixnum, default: 3306
attribute :installSampleData, kind_of: [TrueClass, FalseClass], default: false
attribute :useDefaultConfigParams, kind_of: [TrueClass, FalseClass], default: true
attribute :baseUrl, kind_of: String
attribute :replaceHtaccessFile, kind_of: [TrueClass, FalseClass], default: false
attribute :noDownload, kind_of: [TrueClass, FalseClass], default: false
attribute :forceUseDb, kind_of: [TrueClass, FalseClass], default: false
attribute :filename, kind_of: String
attribute :command, kind_of: String
attribute :username, kind_of: String
attribute :password, kind_of: String
attribute :email, kind_of: String
attribute :firstname, kind_of: String
attribute :lastname, kind_of: String
attribute :role, kind_of: String, default: 'Administrators'
attribute :cachekey, kind_of: String
attribute :banner_id, kind_of: String
attribute :page_id, kind_of: String
attribute :revision_id, kind_of: String
attribute :config_path, kind_of: String
attribute :scope, kind_of: String, default: 'default'
attribute :scopeid, kind_of: Fixnum, default: 0
attribute :encrypt, kind_of: [TrueClass, FalseClass], default: false
attribute :decrypt, kind_of: [TrueClass, FalseClass], default: false
attribute :query, kind_of: String
attribute :website, kind_of: String
attribute :store, kind_of: String
attribute :count, kind_of: Fixnum
attribute :locale, kind_of: String, equal_to: %w(cs_CZ ru_RU bg_BG en_US it_IT sr_RS sr_Cyrl_RS sr_Latn_RS pl_PL en_GB de_DE sk_SK fr_FR es_AR de_AT)
attribute :config_path, kind_of: String
attribute :config_value, kind_of: String
attribute :addtime, kind_of: [TrueClass, FalseClass], default: false
attribute :compression, kind_of: String
attribute :onlycommand, kind_of: [TrueClass, FalseClass], default: false
attribute :nosingletransaction, kind_of: [TrueClass, FalseClass], default: false
attribute :humanreadable, kind_of: [TrueClass, FalseClass], default: false
attribute :stdout, kind_of: [TrueClass, FalseClass], default: false
attribute :strip, kind_of: String
attribute :force, kind_of: [TrueClass, FalseClass], default: false
attribute :class_type, kind_of: String, equal_to: %w(block model helper)
attribute :class_name, kind_of: String
attribute :status, kind_of: String, equal_to: %w(on off)
attribute :global, kind_of: [TrueClass, FalseClass], default: false
attribute :log_filename, kind_of: String
attribute :addcategories, kind_of: [TrueClass, FalseClass], default: false
attribute :addproducts, kind_of: [TrueClass, FalseClass], default: false
attribute :addcmspages, kind_of: [TrueClass, FalseClass], default: false
attribute :addblocks, kind_of: [TrueClass, FalseClass], default: false
attribute :addhelpers, kind_of: [TrueClass, FalseClass], default: false
attribute :addmodels, kind_of: [TrueClass, FalseClass], default: false
attribute :addsetup, kind_of: [TrueClass, FalseClass], default: false
attribute :addall, kind_of: [TrueClass, FalseClass], default: true
attribute :modman, kind_of: [TrueClass, FalseClass], default: false
attribute :addreadme, kind_of: [TrueClass, FalseClass], default: false
attribute :addcomposer, kind_of: [TrueClass, FalseClass], default: false
attribute :authorname, kind_of: String
attribute :authoremail, kind_of: String
attribute :description, kind_of: String
attribute :vendorNamespace, kind_of: String
attribute :moduleName, kind_of: String
attribute :codePool, kind_of: String, equal_to: %w(local community), default: 'local'
attribute :observertype, kind_of: String, equal_to: %w(adminhtml global frontend)
attribute :logjunit, kind_of: String
attribute :entityType, kind_of: String
attribute :attributeCode, kind_of: String
attribute :theme, kind_of: String
attribute :originalTheme, kind_of: String, default: 'base/default'
attribute :package_key, kind_of: String
attribute :code, kind_of: String
attribute :job, kind_of: String
attribute :ignoredata, kind_of: [TrueClass, FalseClass], default: false
attribute :id, kind_of: String
attribute :unserialize, kind_of: [TrueClass, FalseClass], default: false
attribute :fpc, kind_of: [TrueClass, FalseClass], default: false
attribute :all, kind_of: [TrueClass, FalseClass], default: false
attribute :format, kind_of: String
attribute :define, kind_of: String
attribute :stop_on_error, kind_of: [TrueClass, FalseClass], default: false
attribute :script, kind_of: String
attribute :n98_module, kind_of: String
attribute :quietMode, kind_of: [TrueClass, FalseClass], default: false
attribute :verboseMode, kind_of: [TrueClass, FalseClass], default: false
attribute :debugMode, kind_of: [TrueClass, FalseClass], default: false