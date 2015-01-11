require 'test_plugin_helper'

class ForemanHostRundeckTest < ActiveSupport::TestCase
  setup do
    User.current = User.find_by_login "admin"
    @host = FactoryGirl.create(:host, :operatingsystem => FactoryGirl.create(:operatingsystem),
                               :architecture => FactoryGirl.create(:architecture))
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
    @host.puppetclasses = [FactoryGirl.create(:puppetclass, :environments => [@host.environment])]
    @host.params['rundeckfacts'] = "kernelversion, ipaddress\n"
    @host.save!
    rundeck = RundeckFormatter.new(@host).output
    assert rundeck[@host.name]['tags'].include?("class=#{@host.puppetclasses.first.name}"), 'puppet class missing'
    assert rundeck[@host.name]['tags'].include?('kernelversion=undefined'), 'kernelversion fact missing'
    assert rundeck[@host.name]['tags'].include?('ipaddress=undefined'), 'ipaddress fact missing'
  end

end
