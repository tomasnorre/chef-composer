actions :install, :remove, :update

default_action :install

attribute :target_dir, :kind_of => String, :name_attribute => true
attribute :global_bin_dir, :default => "/usr/local/bin", :kind_of => String
attribute :global
attribute :owner, :default => "root", :kind_of => [String, Integer]
attribute :group, :default => "admin", :kind_of => [String, Integer]
attribute :source, :default => "https://getcomposer.org/composer.phar", :kind_of => [String]
