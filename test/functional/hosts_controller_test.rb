require 'test_plugin_helper'

class HostsControllerTest < ActionController::TestCase
  setup do
    User.current = User.find_by_login "admin"
  end


    test "index returns YAML output for rundeck" do
      get :index, {:format => 'yaml'}, set_session_user
      hosts = YAML.load(@response.body)
      assert_not_empty hosts
      host = Host.first
      unless (host.nil? || host.name.nil? || hosts.nil? || hosts[host.name].nil?)
        assert_equal host.os.name, hosts[host.name]["osName"] # rundeck-specific field
      end
    end

    test "show returns YAML output for rundeck" do
      host = Host.first
      get :show, {:id => host, :format => 'yaml'}, set_session_user
      yaml = YAML.load(@response.body)
      unless (host.nil? || host.name.nil? || host.os.nil? || yaml[host.name].nil?)
        assert_kind_of Hash, yaml[host.name]
        assert_equal host.name, yaml[host.name]["hostname"]
        assert_equal host.os.name, yaml[host.name]["osName"]  # rundeck-specific field
      end
    end
end