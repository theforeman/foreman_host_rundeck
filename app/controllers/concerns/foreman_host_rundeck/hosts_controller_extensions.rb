module ForemanHostRundeck
  module HostsControllerExtensions
    def index
      if params[:format] == 'yaml'
        result = {}
        hosts = resource_base.search_for(params[:search], :order => params[:order]).includes(included_associations)
        hosts.each { |h| result.update(RundeckFormatter.new(h).output) }
        render :plain => result.to_yaml
      else
        super
      end
    end
    def show
      if params[:format] == 'yaml'
        render :plain => RundeckFormatter.new(@host).output.to_yaml
      else
        super
      end
    end
  end
end
