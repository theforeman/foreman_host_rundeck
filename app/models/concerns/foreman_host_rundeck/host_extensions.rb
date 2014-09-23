module ForemanHostRundeck
  module HostExtensions
    extend ActiveSupport::Concern

    included do
    end


    # returns a rundeck output
    def rundeck
      rdecktags = puppetclasses_names.map{|k| "class=#{k}"}
      unless params["rundeckfacts"].empty?
        rdecktags += params["rundeckfacts"].gsub(/\s+/, '').split(',').map { |rdf| "#{rdf}=" + (facts_hash[rdf] || "undefined") }
      end
      { name => { "description" => comment, "hostname" => name, "nodename" => name,
                  "Environment" => environment.name,
                  "osArch" => arch.name, "osFamily" => os.family, "osName" => os.name,
                  "osVersion" => os.release, "tags" => rdecktags,
                  "username" => params["rundeckuser"] || "root" }
      }
    rescue => e
      logger.warn "Failed to fetch rundeck info for #{to_s}: #{e}"
      {}
    end

    module ClassMethods
    end
  end
end
