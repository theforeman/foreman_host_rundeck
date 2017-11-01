require 'test_plugin_helper'

class ForemanHostRundeckTest < ActiveSupport::TestCase
  setup do
    User.current = User.find_by_login "admin"
    @host = FactoryBot.create(:host, :operatingsystem => FactoryBot.create(:operatingsystem),
                               :architecture => FactoryBot.create(:architecture))
  end

  test "#rundeck returns hash" do
    rundeck = RundeckFormatter.new(@host).output
    assert_kind_of Hash, rundeck
    assert_equal [@host.name], rundeck.keys
    assert_kind_of Hash, rundeck[@host.name]
    assert_equal @host.hostname, rundeck[@host.name]['hostname']
    assert_equal @host.puppetclasses, rundeck[@host.name]['tags']
  end

  test "#rundeck returns extra facts as tags" do
    @host.puppetclasses = [FactoryBot.create(:puppetclass, :environments => [@host.environment])]
    @host.params['rundeckfacts'] = "kernelversion, ipaddress\n"
    @host.save!
    rundeck = RundeckFormatter.new(@host).output
    assert rundeck[@host.name]['tags'].include?("class=#{@host.puppetclasses.first.name}"), 'puppet class missing'
    assert rundeck[@host.name]['tags'].include?('kernelversion=undefined'), 'kernelversion fact missing'
    assert rundeck[@host.name]['tags'].include?('ipaddress=undefined'), 'ipaddress fact missing'
  end

  test "#rundeck returns global parameters with values as tags" do
    @host.puppetclasses = [FactoryBot.create(:puppetclass, :environments => [@host.environment])]
    @host.params['rundeckfacts'] = "kernelversion, ipaddress\n"
    @host.params['rundeckglobalparams'] = "stage\n"
    @host.params['stage'] = "prod"
    @host.save!
    rundeck = RundeckFormatter.new(@host).output
    assert rundeck[@host.name]['tags'].include?('stage=prod'), 'stage parameter missing'
  end

  test "#rundeck returns undefined global parameters as tags" do
    @host.puppetclasses = [FactoryBot.create(:puppetclass, :environments => [@host.environment])]
    @host.params['rundeckfacts'] = "kernelversion, ipaddress\n"
    @host.params['rundeckglobalparams'] = "someparam, stage\n"
    @host.save!
    rundeck = RundeckFormatter.new(@host).output
    assert rundeck[@host.name]['tags'].include?('someparam=undefined'), 'someparam parameter missing'
    assert rundeck[@host.name]['tags'].include?('stage=undefined'), 'stage parameter missing'
  end

  test "#rundeck does not returns global parameters that are not in params['rundeckglobalparams']" do
    @host.puppetclasses = [FactoryBot.create(:puppetclass, :environments => [@host.environment])]
    @host.params['rundeckfacts'] = "kernelversion, ipaddress\n"
    @host.params['rundeckglobalparams'] = "someparam\n"
    @host.save!
    rundeck = RundeckFormatter.new(@host).output
    refute rundeck[@host.name]['tags'].include?('stage=undefined')
  end
end
