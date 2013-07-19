actions :install, :script, :selfupdate, :shell, :uninstall, :admin_notifications, :admin_user_changepassword, :admin_user_create, :admin_user_list, :cache_clean, :cache_disable, :cache_enable, :cache_flush, :cache_list, :cms_banner_toggle, :cms_page_publish, :config_dump, :config_get, :config_search, :config_set, :customer_changepassword, :customer_create, :customer_create_dummy, :customer_info, :customer_list, :db_console, :db_drop, :db_dump, :db_import, :db_info, :db_query, :design_demonotice, :dev_class_lookup, :dev_console, :dev_ide_phpstorm_meta, :dev_log, :dev_log_db, :dev_log_size, :dev_module_create, :dev_module_list, :dev_module_observer_list, :dev_module_rewrite_conflicts, :dev_module_rewrite_list, :dev_profiler, :dev_report_count, :dev_setup_script_attribute, :dev_symlinks, :dev_templatehints, :dev_templatehintsblocks, :dev_theme_duplicates, :dev_theme_list, :dev_translate_admin, :dev_translate_shop, :extension_download, :extension_install, :extension_list, :extension_search, :extension_upgrade, :index_list, :index_reindex, :index_reindex_all, :localconfig_generate, :sys_check, :sys_cron_history, :sys_cron_list, :sys_cron_run, :sys_info, :sys_maintenance, :sys_modules_list, :sys_setup_compareversions, :sys_setup_run, :sys_store_config_baseurl_list, :sys_store_list, :sys_url_list, :sys_website_list
default_action :selfupdate

attribute :path, :kind_of => String, :name_attribute => true
attribute :dbHost, :kind_of => String, :default => "localhost"
attribute :dbUser, :kind_of => String
attribute :dbPass, :kind_of => String
attribute :dbName, :kind_of => String
attribute :installSampleData, :kind_of => [ TrueClass, FalseClass ], :default => false
attribute :useDefaultConfigParams, :kind_of => [ TrueClass, FalseClass ], :default => true
attribute :magentoVersionByName, :kind_of => String, :default => "1.7.0.2"
attribute :installationFolder, :kind_of => String
attribute :baseUrl, :kind_of => String
attribute :filename, :kind_of => String
attribute :command, :kind_of => String
attribute :username, :kind_of => String
attribute :password, :kind_of => String
attribute :email, :kind_of => String
attribute :firstname, :kind_of => String
attribute :lastname, :kind_of => String
attribute :cachekey, :kind_of => String
attribute :banner_id, :kind_of => String
attribute :page_id, :kind_of => String
attribute :revision_id, :kind_of => String
attribute :config_path, :kind_of => String
attribute :scope, :kind_of => String, :default => "default"
attribute :scopeid, :kind_of => String, :default => "0"
attribute :encrypt, :kind_of => [ TrueClass, FalseClass ], :default => false
attribute :decrypt, :kind_of => [ TrueClass, FalseClass ], :default => false
attribute :query, :kind_of => String
attribute :website, :kind_of => String
attribute :count, :kind_of => Fixnum
attribute :locale, :kind_of => String, :equal_to => ["cs_CZ", "ru_RU", "bg_BG", "en_US", "it_IT", "sr_RS", "sr_Cyrl_RS", "sr_Latn_RS", "pl_PL", "en_GB", "de_DE", "sk_SK", "fr_FR", "es_AR", "de_AT"]