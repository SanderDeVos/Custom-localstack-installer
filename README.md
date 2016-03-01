# Custom-localstack-installer
This repository contains a script which will install a local stack to your needs. You can even choose how to call your document root folder(and create it for you). It will also edit some basic but helpfull files (mostly created for local drupal development) such as PHP memory limit etc. 

The script will also copy a 'home' folder to the document root which will contain a new look for the localhost page. This folder also contains a script 'auto_vhosts.command' which will edit the hosts and httpd-vhosts files according to the sites inside the documentroot(they make sure you can access the local website) and will link the 'home' page to the localhost. This page will give you all the current local sites(folders in documentroot) and has the ability to connect to a GitLab repository. This will show all the available projects for you and will make a list of them. With this list you have the option to select a repository and clone the project. 

### Install Script
The script currently has the ability to install the following things:
  * Apache
  * MySQL
  * PHP
  * PHPMyAdmin
  * Drush
  * Sass/Compass

The actual script are available in the scripts folder just in case you would like to use them seperatly.

  
### Localhost page
After installing everything you will be able to acces your localhost by simply surfing to "localhost". This is basically the index.php in the home folder in your document root(copied by the install script).
In the home page there is a config.sample.php. Rename this file to config.php or copy paste is and change the name to config.php. 

There are a few settings in this file you will have to set.
  * $documentrootname (Give the name of your document root folder)
  * $gitlabintegration (Set to 'yes' if you want the gitlab integration, 'no' if you don't)
   * $token (Give your GitLab Priate Token here. This is required in order to communicate with the GitLab API)
   * $giturl (Give the GitLab URL from your repository. Example: https://git.company.com/api/v3/projects/ and change company.com to your company domain.
  * A few more variables available to edit but not required to edit to make the page work. 

Contributions and requests are welcome.

Sponsor:

![alt text](http://wbase.be "Wbase.be")
