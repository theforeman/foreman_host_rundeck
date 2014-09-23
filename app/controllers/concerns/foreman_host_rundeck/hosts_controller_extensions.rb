module ForemanHostRundeck
  module HostsControllerExtensions
    extend ActiveSupport::Concern

    included do
      alias_method_chain :index, :rundeck
      alias_method_chain :show, :rundeck
    end

    def index_with_rundeck
      if params[:format] == 'yaml'
        result = {}
        hosts = resource_base.search_for(params[:search], :order => params[:order]).includes(included_associations)
        hosts.each { |h| result.update(RundeckFormatter.new(h).output) }
        render :text => result.to_yaml
      else
        index_without_rundeck
      end
    end

    def show_with_rundeck
      if params[:format] == 'yaml'
        render :text => RundeckFormatter.new(@host).to_yaml
      else
        show_without_rundeck
      end
    end

  end
end
