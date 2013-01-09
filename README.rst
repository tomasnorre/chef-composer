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

Install composer packages from Packagist_
================

.. _Packagist : http://packagist.org/
