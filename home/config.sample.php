<?php

/**
 *
 *  This is just a simple config file to store your web root and a few other items
 *
 */


/** Document root settings */
//What is the name of the documentroot folder?
$documentrootname = "Wbase";


/** GitLab settings */
//Do you want GitLab Integration? yes or no
$gitlabintegration = "no";
//GitLab Private Token for api connection
$token = "enter_private_token_here";
//GitLab url for api connection, edit domain but leave /api/v3/projects/
$giturl = "https://git.company.com/api/v3/projects/";












/*
*
*  Icon file names you would like to display next to the link to each site.
*  In order of the priority they should be used.
*
*/
$icons = array( 'favicon.ico',  'druplicon.png');

/*
*
*  Development tools you want displayed in the top navigation bar. Each item should be
*  an array containing keys 'name' and 'url'. An example is included (commented out) below.
*
*/
$devtools = array(
//	array( 'name' => 'Tool', 'url' => 'http://example.com/' ),
	array( 'name' => 'PHPMyAdmin', 'url' => 'http://localhost/phpmyadmin' ),
);

/*
*
*  Directory names of sites you want to hide from the page. If you're using multiple directories
*  in $dir be aware that any directory names in the array below that show up in any of 
*  your directories will be hidden.
* 
*/
$hiddensites = array( 'home', 'sqldumps');