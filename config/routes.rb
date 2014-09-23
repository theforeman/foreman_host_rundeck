Rails.application.routes.draw do

  match '/rundeck/hosts', :to => 'foreman_host_rundeck/hosts#index'

  constraints(:id => /[^\/]+/) do
    match '/rundeck/hosts/:id', :to => 'foreman_host_rundeck/hosts#show'
  end
end
