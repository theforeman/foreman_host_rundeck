module ForemanHostRundeck
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/services"]

    initializer 'foreman_host_rundeck.register_plugin', :before => :finisher_hook do |app|
      Foreman::Plugin.register :foreman_host_rundeck do
        requires_foreman '>= 1.17'

        # Add permissions
        security_block :foreman_host_rundeck do
          permission :view_foreman_host_rundeck, {:hosts_controller => [:index, :show]}
        end
      end
    end

    #Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
        HostsController.send(:prepend, ForemanHostRundeck::HostsControllerExtensions)
       end
    end
  end
end
