class RundeckFormatter
  attr_reader :host
  attr_reader :params

  delegate :comment, :name, :arch, :environment, :os, :facts_hash, :puppetclasses_names, :to => :params, :to => :host
  delegate :logger, :to => :Rails

  def initialize(host, params)
    @host = host
    @params = params
  end

    def output
    rdecktags = puppetclasses_names.map { |k| "class=#{k}" }
    unless params['rundeckfacts'].empty?
      rdecktags += params['rundeckfacts'].gsub(/\s+/, '').split(',').map { |rdf| "#{rdf}=" + (facts_hash[rdf] || 'undefined') }
    end

    {name => {'description' => comment, 'hostname' => name, 'nodename' => name,
              'Environment' => environment.name,
              'osArch' => arch.name, 'osFamily' => os.family, 'osName' => os.name,
              'osVersion' => os.release, 'tags' => rdecktags,
              'username' => params['rundeckuser'] || 'root'}
    }
  rescue => e
    logger.warn "Failed to fetch rundeck info for #{to_s}: #{e}"
    {}
  end
end
