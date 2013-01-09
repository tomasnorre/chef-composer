++++++++++++++++++++++++
PHP composer chef recipe
++++++++++++++++++++++++

:Author: Michael Klapper <development@morphodo.com>
:Description: Chef recipe to manage/install composer packages
:Homepage: http://www.morphodo.com
:Tags: PHP, Composer

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

Manage composer packages from Packagist_
================
Usage with existing ``composer.json`` configuration file.

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

Create a project without ``composer.json`` file
----------------
You can use Composer to create new projects from an existing package. This is the equivalent of doing a git clone/svn checkout followed by a composer install of the vendors.

The directory is not allowed to exist, it will be created during installation.
::
  composer_package "typo3/neos-base-distribution" do
    action :create_project
    install_path "/var/www/neos
  end


.. _Packagist : http://packagist.org/
