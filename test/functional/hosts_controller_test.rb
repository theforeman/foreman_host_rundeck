require 'test_plugin_helper'

class HostsControllerTest < ActionController::TestCase
  setup do
    User.current = User.find_by_login "admin"
    # disable_orchestration
    # @host = Host.create(:name => "myfullhost",
    #                     :mac                => "aabbecddeeff",
    #                     :ip                 => "2.3.4.99",
    #                     :domain_id          => domains(:mydomain).id,
    #                     :operatingsystem_id => operatingsystems(:redhat).id,
    #                     :architecture_id    => architectures(:x86_64).id,
    #                     :environment_id     => environments(:production).id,
    #                     :subnet_id          => subnets(:one).id,
    #                     :disk               => "empty partition",
    #                     :puppet_proxy_id    => smart_proxies(:puppetmaster).id,
    #                     :root_pass          => "123456789",
    #                     :location_id        => taxonomies(:location1).id,
    #                     :organization_id    => taxonomies(:organization1).id
    # )
  end


     #test "index returns YAML output for rundeck" do
    #   get :index, set_session_user
    #   hosts = YAML.load(@response.body)
    #   assert_not_empty hosts
    #   host = Host.first
    #   unless (host.nil? || host.name.nil? || hosts.nil? || hosts[host.name].nil?)
    #     assert_equal host.os.name, hosts[host.name]["osName"] # rundeck-specific field
    #   end
    # end
    # #

    # test "show returns YAML output for rundeck" do
    #   binding.pry
    #   host = Host.first
    #   get :show, {:id => host}, set_session_user
    #   yaml = YAML.load(@response.body)
    #   unless (host.nil? || host.name.nil? || host.os.nil? || yaml[host.name].nil?)
    #     assert_kind_of Hash, yaml[host.name]
    #     assert_equal host.name, yaml[host.name]["hostname"]
    #     assert_equal host.os.name, yaml[host.name]["osName"]  # rundeck-specific field
    #   end
    #  end
end