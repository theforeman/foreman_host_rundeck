class RundeckFormatter
  attr_reader :host

  delegate :comment, :name, :arch, :environment, :os, :facts_hash, :puppetclasses_names, :params, :to => :host
  delegate :logger, :to => :Rails

  def initialize(host)
    @host = host
  end

    def output
    rdecktags = puppetclasses_names.map { |k| "class=#{k}" }
    unless params['rundeckfacts'].empty?
      rdecktags += format_tags(params,'rundeckfacts', facts_hash)
    end
    unless params['rundeckglobalparams'].empty?
      rdecktags += format_tags(params, 'rundeckglobalparams', params)
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

  def format_tags params, tag, tag_location
    params[tag].gsub(/\s+/, '').split(',').map { |rdf| "#{rdf}=" + (tag_location[rdf] || 'undefined') }
  end
end
