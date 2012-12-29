actions :install, :update, :create_project

default_action :install

attribute :project_dir, :kind_of => String, :name_attribute => true
attribute :install_path, :kind_of => [String, NilClass], :default => "/opt"
attribute :prefer_source, :kind_of => [String, NilClass]
attribute :prefer_dist, :kind_of => [String, NilClass]
attribute :dev, :equal_to => [true, false], :default => false
attribute :optimize_autoloader, :equal_to => [true, false], :default => false
attribute :no_scripts, :equal_to => [true, false], :default => false
attribute :verbose, :equal_to => [true, false], :default => false
attribute :keep_vcs, :equal_to => [true, false], :default => false
attribute :stability, :kind_of => String, :default => "stable"
attribute :repository_url, :kind_of => [String, NilClass]