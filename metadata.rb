name             'composer'
maintainer       'Tomas Norre Mikkelsen'
maintainer_email 'tomasnorre@gmail.com'
license          'MIT'
description      'Recipe to install PHP package manager'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rst'))
version          '0.3.0'

%w{ ubuntu debian centos redhat fedora }.each do |os|
	supports os
end
