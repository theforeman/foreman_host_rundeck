module ForemanHostRundeck

  # Example: Plugin's HostsController inherits from Foreman's HostsController
  class HostsController < ::HostsController

    before_filter :find_by_name, :only => [:show]

    # change layout if needed
    # layout 'foreman_host_rundeck/layouts/new_layout'

    def index
      super
      result = {}
      @hosts.each{|h| result.update(h.rundeck)}
      render :text => result.to_yaml
    end

    def show
      binding.pry
      render :text => @host.rundeck.to_yaml
    end

  end
end
