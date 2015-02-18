class RundeckFormatter
  attr_reader :host
  attr_reader :query_params

  delegate :comment, :name, :arch, :environment, :os, :facts_hash, :puppetclasses_names, :params, :to => :host
  delegate :logger, :to => :Rails

  def initialize(host, query_params)
    @host = host
    @query_params = query_params
  end

    def output
    rdecktags = puppetclasses_names.map { |k| "class=#{k}" }
    merged_params = params.merge(query_params)
    unless merged_params['rundeckfacts'].empty?
      rdecktags += merged_params['rundeckfacts'].gsub(/\s+/, '').split(',').map { |rdf| "#{rdf}=" + (facts_hash[rdf] || 'undefined') }
    end

    {name => {'description' => comment, 'hostname' => name, 'nodename' => name,
              'Environment' => environment.name,
              'osArch' => arch.name, 'osFamily' => os.family, 'osName' => os.name,
              'osVersion' => os.release, 'tags' => rdecktags,
              'username' => merged_params['rundeckuser'] || 'root'}
    }
  rescue => e
    logger.warn "Failed to fetch rundeck info for #{to_s}: #{e}"
    {}
  end
end
