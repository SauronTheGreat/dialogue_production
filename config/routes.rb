ActionController::Routing::Routes.draw do |map|
  map.resources :student_group_questionnaires

  map.resources :options

  map.resources :questions
  map.resources :player_answers

  map.resources :questionnaires

  map.resources :option_values

  map.resources :issue_options

  map.resources :player_scorecards

  map.resources :game_datas

  map.resources :scoreqs

  map.resources :student_group_metrics

  map.resources :metrics

  map.resources :offers

  map.resources :planqs


  map.resources :sent, :mailbox
  map.inbox '/inbox', :controller => "mailbox", :action=>"index"
  map.plandoc '/plandoc', :controller => "players", :action=>"plandoc"
  map.rulelist '/rulelist', :controller => "sent", :action=>"rulelist"
  map.scorelist '/scorelist', :controller => "sent", :action=>"scorelist"
  map.offer_chart '/offer_chart', :controller => 'game_statistics', :action => 'offer_chart'
  map.student_data_view '/student_data_view', :controller => 'game_statistics', :action => 'student_data_view'
  map.data_viewer '/data_viewer', :controller => 'game_statistics', :action => 'data_viewer'
  map.questionnaire_selection '/questionnaire_selection', :controller => 'questionnaires', :action => 'selection_mode'
  map.end_negotiation '/end_negotiation', :controller => 'game_statistics', :action => 'end_negotiation'
  map.agreed '/agreed', :controller => 'game_statistics', :action => 'agreed'
  map.switch_back '/switch_back', :controller => 'welcome', :action => 'switch_back'
#  map.download_data '/download_data', :controller => 'game_statistics', :action => 'download_data'
  map.student_data_options '/student_data_options',:controller=>'game_statistics',:action=>'student_data_options'
  map.student_general_statistics '/student_general_statistics',:controller=>'game_statistics',:action=>'general_statistics'
  map.download_data '/download_data',:controller=>:student_groups,:action=>'download_data'
  map.download_csv '/download_csv',:controller=>:imports,:action=>'download_csv'
  map.use_questionnaire'/use_questionnaire',:controller => :student_groups,:action => 'populate_db'
  map.study_selection '/study_selection',:controller=>:case_studies,:action=>'study_selection'
  map.list_questions '/list_questions',:controller=>:questions,:action=>'list'
  map.destroy_role '/destroy_role',:controller=>:roles,:action=>'destroy'

  map.resources :messages, :member => { :reply => :get, :forward => :get, :reply_all => :get }

  map.resources :student_group_users

  map.resources :facilitator_groups

  map.resources :players

  map.resources :games

  map.resources :rules

  map.resources :student_group_rules


  map.game_select '/game_select', :controller => "welcome", :action=>"game_select"
  map.offer_chart '/offer_chart', :controller => "game_statistics", :action=>"offer_chart"

  map.new_rule_admin '/new_rule_admin',:controller=>"rules",:action=>'new_admin'
  map.create_rule_admin '/create_rule_admin',:controller=>"rules",:action=>'create_admin'

  
  map.devise_for :users #  ,  :controllers => { :registrations => "users/registrations" }
  map.resources :users
  map.resources :briefings
  map.resources :categories
  map.resources :roles
  map.resources :issues
  map.resources :case_studies
  map.resources :student_groups
  map.resources :clients
  map.resources :types

  map.resources :imports
  map.import_proc '/import/proc/:id', :controller => "imports", :action => "proc_csv"
  map.grouprules '/student_group_rules/rules_by_group/:id', :controller=>'student_group_rules', :action => 'rules_by_group'



  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.

  map.root :controller => "welcome", :action=>"index"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
