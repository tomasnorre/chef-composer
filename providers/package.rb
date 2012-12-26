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
end