require File.expand_path('../lib/foreman_host_rundeck/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "foreman_host_rundeck"
  s.version     = ForemanHostRundeck::VERSION
  s.date        = Date.today.to_s
  s.authors     = ["Ori Rabin"]
  s.email       = ["orabin@redhat.com"]
  s.homepage    = "TODO"
  s.summary     = "Plugin to create rundeck output for hosts."
  s.description = "Plugin to create rundeck output for hosts."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "deface"
  #s.add_development_dependency "sqlite3"
end
