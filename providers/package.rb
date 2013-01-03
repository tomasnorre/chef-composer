action :install do
	arguments = "--no-interaction --no-ansi -q"
	Chef::Log.info("Install package in directory: #{new_resource.name}")

	if !::File.directory?(new_resource.name)
		raise "#{new_resource.name} is not a directory"
	end
	if !::File.exists?("#{new_resource.name}/composer.json")
		raise "#{new_resource.name}/composer.json is not available"
	end

	if new_resource.verbose
		arguments = " --no-interaction --verbose"
	end
	if new_resource.dev
		arguments += " --dev"
	end
	if new_resource.prefer_source
		arguments += " --prefer-source"
	end
	if new_resource.prefer_dist
		arguments += " --prefer-dist"
	end
	if new_resource.optimize_autoloader
		arguments += " --optimize-autoloader"
	end
	if new_resource.no_scripts
		arguments += " --no-scripts"
	end
	
	execute "install-composer-packages" do
		cwd new_resource.project_dir
		command "composer install #{arguments}"
		
		only_if "composer help"
	end

	# My state has changed so I'd better notify observers
	new_resource.updated_by_last_action(true)
end

action :update do
	arguments = "--no-interaction --no-ansi -q"
	Chef::Log.info("Update package: #{new_resource.name}")

	if !::File.directory?(new_resource.name)
		raise "#{new_resource.name} is not a directory"
	end
	if !::File.exists?("#{new_resource.name}/composer.json")
		raise "#{new_resource.name}/composer.json is not available"
	end

	if new_resource.verbose
		arguments = " --no-interaction --verbose"
	end
	if new_resource.dev
		arguments += " --dev"
	end
	if new_resource.prefer_source
		arguments += " --prefer-source"
	end
	if new_resource.prefer_dist
		arguments += " --prefer-dist"
	end
	if new_resource.optimize_autoloader
		arguments += " --optimize-autoloader"
	end
	if new_resource.no_scripts
		arguments += " --no-scripts"
	end
	
	execute "update-composer-packages" do
		cwd new_resource.project_dir
		command "composer update #{arguments}"
		
		only_if "composer help"
	end

	# My state has changed so I'd better notify observers
	new_resource.updated_by_last_action(true)
end


action :create_project do
	arguments = "--no-interaction --no-ansi --stability #{new_resource.stability}"
	Chef::Log.info("Composer create-project: #{new_resource.name}")
	
	if new_resource.dev
		arguments += " --dev"
	end
	if new_resource.prefer_source
		arguments += " --prefer-source"
	end
	if new_resource.prefer_dist
		arguments += " --prefer-dist"
	end
	if new_resource.keep_vcs
		arguments += " --keep-vcs"
	end
	if new_resource.no_scripts
		arguments += " --no-scripts"
	end
	if new_resource.repository_url
		arguments += " --repository-url #{new_resource.repository_url}"
	end

	execute "composer create-project" do
		command "composer create-project #{arguments} #{new_resource.name} #{new_resource.install_path}"
		not_if "test -d #{new_resource.install_path}"
	end

	# My state has changed so I'd better notify observers
	new_resource.updated_by_last_action(true)
end

action :install_dynamic do
	arguments = "--no-interaction --no-ansi "
	Chef::Log.info("Install dynamic packages: #{new_resource.name}")

	if new_resource.prefer_source
		arguments += " --prefer-source"
	end
	if new_resource.prefer_dist
		arguments += " --prefer-dist"
	end
	if new_resource.no_scripts
		arguments += " --no-scripts"
	end

	directory new_resource.install_path do
		owner "root"
		group "root"
		mode 00755
		recursive true
		action :create
		
		not_if "test -d #{new_resource.install_path}"
	end

	template "composer.json.erb" do
		source "composer.json.erb"
		cookbook "composer"
		path "#{new_resource.install_path}/composer.json"
		mode 0644
		variables(
			:bin_dir => new_resource.bin_dir,
			:packages => new_resource.packages,
			:config => new_resource.config,
			:scripts => new_resource.scripts,
			:stability => new_resource.stability
		)
	end

	execute "composer install" do
		cwd new_resource.install_path
		command "composer install #{arguments}"
		only_if "test -f #{new_resource.install_path}/composer.json"
	end

	# My state has changed so I'd better notify observers
	new_resource.updated_by_last_action(true)
end