require 'deface'

module ForemanHostRundeck
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/overrides"]

    # Add any db migrations
    # initializer "foreman_host_rundeck.load_app_instance_data" do |app|
    #   app.config.paths['db/migrate'] += ForemanHostRundeck::Engine.paths['db/migrate'].existent
    # end

    initializer 'foreman_host_rundeck.register_plugin', :after=> :finisher_hook do |app|
      Foreman::Plugin.register :foreman_host_rundeck do
        requires_foreman '>= 1.4'

        # Add permissions
        security_block :foreman_host_rundeck do
          permission :view_foreman_host_rundeck, {:hosts_controller => [:index, :show] }
        end

        # Add a new role called 'Discovery' if it doesn't exist
        #role "ForemanHostRundeck", [:view_foreman_host_rundeck]

        #add menu entry
        # menu :top_menu, :template,
        #      :url_hash => {:controller => :'foreman_host_rundeck/hosts', :action => :new_action },
        #      :caption  => 'ForemanHostRundeck',
        #      :parent   => :hosts_menu,
        #      :after    => :hosts

        # add dashboard widget
        #widget 'foreman_host_rundeck_widget', :name=>N_('Foreman plugin template widget'), :sizex => 4, :sizey =>1
      end
    end

    #Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
        Host::Managed.send(:include, ForemanHostRundeck::HostExtensions)
        HostsHelper.send(:include, ForemanHostRundeck::HostsHelperExtensions)
      rescue => e
        puts "ForemanHostRundeck: skipping engine hook (#{e.to_s})"
      end
    end

    # rake_tasks do
    #   Rake::Task['db:seed'].enhance do
    #     ForemanHostRundeck::Engine.load_seed
    #   end
    # end

  end
end
