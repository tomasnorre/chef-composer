++++++++++++++++++++++++
PHP composer chef recipe
++++++++++++++++++++++++

:Author: Michael Klapper <development@morphodo.com>
:Description: Chef recipe to manage/install composer packages
:Homepage: http://www.morphodo.com
:Tags: PHP, Composer

.. contents:: **Table of Contents**
  :depth: 3

Install composer
================

Global installation
----------------
This way composer is installed under ``/opt/composer``, the binary is symlinked into ``/usr/local/bin``.
::
  include_recipe "composer"

Local installation
----------------
To install ``composer`` locally for just a project you can use the LWRP as below.
::
  composer "/var/www/domain/htdocs" do
    global false
    action :install
  end

This command will download composer to the htdocs directory ``/var/www/domain/htdocs/composer.phar``.

Update installation
----------------
Just pass the path to the ``composer`` installation to the LWRP and call the ``update`` action.
::
  composer "/var/www/domain/htdocs" do
    action :update
  end

Manage composer packages from Packagist_ with existing ``composer.json`` configuration file
================

Install packages
----------------
From existing ``/var/www/domain/htdocs/composer.json`` file with option ``--dev`` set.
::
  composer_package "/var/www/domain/htdocs" do
    action :install
    dev true
  end

Update packages
----------------
This will update all configured packages from ``composer.json``.
::
  composer_package "/var/www/domain/htdocs" do
    action :update
  end

Install packages without exiting ``composer.json`` file
================

Create a new project
----------------
You can use Composer to create new projects from an existing package. This is the equivalent of doing a git clone/svn checkout followed by a composer install of the vendors.

The directory is not allowed to exist, it will be created during installation.
::
  composer_package "typo3/neos-base-distribution" do
    action :create_project
    install_path "/var/www/neos
  end

Install packages with custom configuration
----------------
You can simply use the ``create`` action to build a new ``composer.json`` file from template and define which packages you would like to install.
::
  composer_package "Install PHP tools for development" do
    action [:create, :update]
    install_path "/opt/composer-libaries"
    packages ({"phpunit/phpunit" => "3.7.*", "phing/phing" => "2.4.*"})
    config ({"bin-dir" => "/usr/local/bin"})
  end


Update `autoload.php`
=============
If you need to update the autoloader because of new classes in a classmap package for example, you can use "dump-autoload" to do that without having to go through an install or update.

Additionally, it can dump an optimized autoloader that converts PSR-0 packages into classmap ones for performance reasons. In large applications with many classes, the autoloader can take up a substantial portion of every request's time. Using classmaps for everything is less convenient in development, but using this option you can still use PSR-0 for convenience and classmaps for performance.
::
  composer_package "/opt/composer-libaries" do
    action :dump_autoload
    optimize true
  end


The composer cookbook in action
=============
- This cookbook is used to manage the PHP development dependencies easily for PylonWorks.Essencebase_ sandbox environment.
- The cookbook is used as dependency of TYPO3-Flow_ recipe to install TYPO3 Flow easily with chef.


How to get this recipe?
================
Using ``Cheffile``
-----------------
For detailed usage instructions visit https://github.com/applicationsonline/librarian and folow the README.md.

::

  site 'http://community.opscode.com/api/v1'

  cookbook "composer",
    :git => "git://github.com/Morphodo/composer.git"

Using ``git clone``
-----------------
Just go into your ``cookbooks`` directory and clone this repository.

::

  git clone git://github.com/Morphodo/composer.git

.. _PylonWorks.Essencebase: http://github.com/PylonWorks/essencebase-chef-recipe
.. _Packagist : http://packagist.org/
.. _TYPO3-Flow: https://github.com/Morphodo/typo3_flow-chef-recipe
