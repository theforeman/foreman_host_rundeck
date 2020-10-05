class RundeckFormatter
  attr_reader :host

  delegate :comment, :name, :arch, :environment, :os, :facts_hash, :puppetclass_names, :params,
           :hostgroup, :organization, :location, :info,  :to => :host
  delegate :logger, :to => :Rails

  def initialize(host, include_enc_output = false)
    @host = host
    @include_enc_output = include_enc_output
  end

    def output
    rdecktags = puppetclass_names.map { |k| "class=#{k}" }
    unless params['rundeckfacts'].empty?
      rdecktags += format_tags(params,'rundeckfacts', facts_hash)
    end

    unless params['rundeckglobalparams'].empty?
      rdecktags += format_tags(params, 'rundeckglobalparams', params)
    end

    rundeck_hash =  { 'description' => comment, 'hostname' => name, 'nodename' => name,
                      'osArch' => arch.name, 'osFamily' => os.family, 'osName' => os.name,
                      'osVersion' => os.release, 'tags' => rdecktags,
                      'username' => params['rundeckuser'] || 'root'}
    rundeck_hash['Hostgroup'] = hostgroup.name unless hostgroup.nil?
    rundeck_hash['Environment'] = environment.name unless environment.nil?
    rundeck_hash['Enc_output'] = info if @include_enc_output

    if SETTINGS[:locations_enabled]
      rundeck_hash['Location'] = location.name unless location.nil?
    end
    if SETTINGS[:organizations_enabled]
      rundeck_hash['Organization'] = organization.name unless organization.nil?
    end

    { name => rundeck_hash }
  rescue => e
    logger.warn "Failed to fetch rundeck info for #{to_s}: #{e}"
    {}
    end

  def format_tags params, tag, tag_location
    params[tag].gsub(/\s+/, '').split(',').map { |rdf| "#{rdf}=" + (tag_location[rdf] || 'undefined') }
  end
end
