require 'test_plugin_helper'

class ForemanHostRundeckTest < ActiveSupport::TestCase
  setup do
    User.current = User.find_by_login "admin"
  end

  test "#rundeck returns hash" do
    h = hosts(:one)
    rundeck = h.rundeck
    assert_kind_of Hash, rundeck
    assert_equal ['my5name.mydomain.net'], rundeck.keys
    assert_kind_of Hash, rundeck[h.name]
    assert_equal 'my5name.mydomain.net', rundeck[h.name]['hostname']
    assert_equal ["class=auth", "class=base", "class=chkmk", "class=nagios", "class=pam"], rundeck[h.name]['tags']
  end

  test "#rundeck returns extra facts as tags" do
    host = hosts(:one)
    h = FactoryGirl.create(:host, :os => host.os, :arch => host.arch, :puppetclasses => host.puppetclasses, :environment => host.environment)
    h.params['rundeckfacts'] = "kernelversion, ipaddress\n"
    h.save!
    rundeck = h.rundeck

    assert rundeck[h.name]['tags'].include?('class=base'), 'puppet class missing'
    assert rundeck[h.name]['tags'].include?('kernelversion=undefined'), 'kernelversion fact missing'
    assert rundeck[h.name]['tags'].include?('ipaddress=undefined'), 'ipaddress fact missing'
  end

end
