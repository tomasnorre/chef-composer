maintainer       "Morphodo"
maintainer_email "development@morphodo.com"
license          "MIT"
description      "Recipe to install PHP package manager"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ ubuntu debian centos redhat fedora }.each do |os|
	supports os
end

depends "php"