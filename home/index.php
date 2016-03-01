<!DOCTYPE html>

<?php
require('config.php');
?>

<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>Local</title>
        <meta name="viewport" content="width=device-width">
        <link rel="stylesheet" href="css/main.css">
		<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>


	</head>

    <body>
		<div class="canvas">

		    <header>

			    <h1>My Local Sites</h1>

			    <nav>
			        <ul>
					<?php
			            foreach ( $devtools as $tool ) {
			            	printf( '<li><a href="%1$s">%2$s</a></li>', $tool['url'], $tool['name'] );
			            }
					?>
			        </ul>
			    </nav>

		    </header>

		    <content class="cf">
				<div class="my-local-sites">
					<?php
					//Get user and put it in path
					$helpwhoami = shell_exec('whoami');
					$whoami = preg_replace('/\s+/','',$helpwhoami);
					$dir = array("/Users/$whoami/$documentrootname/*");
					// Full path of document root
					$docrootpath = "/Users/$whoami/$documentrootname";

					//search for directories in documentroot and display as websites
					foreach ( $dir as $d ) {
						$dirsplit = explode('/', $d);
						$dirname = $dirsplit[count($dirsplit)-2];
						$domain = 'localhost';

						printf( '<ul class="sites %1$s">', $dirname );

						foreach( glob( $d ) as $file )  {

							$project = basename($file);

							if ( in_array( $project, $hiddensites ) ) continue;

							echo '<li>';

							$siteroot = sprintf( 'http://%1$s.%2$s', $project, $domain);

							// Display an icon for the site
							$icon_output = '<span class="no-img"></span>';
							foreach( $icons as $icon ) {
								if ( getfavicon("http://$siteroot") != '' ) {
									$icon_output = getfavicon("http://$siteroot");
									break;
								}
								elseif ( file_exists( $file . '/' . $icon ) ) {
									$icon_output = sprintf( '<img src="%1$s/%2$s">', $siteroot, $icon );
									break;
								} // if ( file_exists( $file . '/' . $icon ) )
								elseif ( file_exists( $file . '/misc/' . $icon ) ) {
									$icon_output = sprintf( '<img src="%1$s/misc/%2$s">', $siteroot, $icon );
									break;
								}

							} // foreach( $icons as $icon )
							echo $icon_output;

							// Display a link to the site
							printf( '<a class="site" href="%1$s">%2$s</a>', $siteroot, $project );

							echo '</li>';

						} // foreach( glob( $d ) as $file )
						echo '</ul>';
					} // foreach ( $dir as $d )

					//search for favicon/icon to display next to site
					function getfavicon($url){
						$fav = '';
						$html = file_get_contents($url);
						$dom = new DOMDocument();
						$dom->loadHTML($html);
						$links = $dom->getElementsByTagName('link');
						for ($i = 0; $i < $links->length; $i++){
							$link = $links->item($i);
							if($link->getAttribute('rel') == 'shortcut icon'){
								$fav = $link->getAttribute('href');
							}
						}
						return $fav;
					}
					?>
				</div>

				<?php
				//If gitlabintegration is set to yes, show getlab repositories you have access to
				if ($gitlabintegration == 'yes') {
					printf('<div class="git-repos">');
					printf('<h1></br></br>Git repos!</h1>');

					//Get Projects list via API
					$header = array("PRIVATE-TOKEN: $token");

					$ch = curl_init("https://git.coworks.be/api/v3/projects/");
					curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
					curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
					curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
					$result = curl_exec($ch);
					curl_close($ch);

					//Parse returned list to an array
					$projectsArray= json_decode($result, true);
					printf ( '<form method="post">' );
					//Loop over the array of projects accessing the list of tags via the API
					foreach ($projectsArray as $project) {
						$projects[$project["id"]] = array
						(
							'name'  => $project["name"],
							'ssh_url_to_repo' => $project["ssh_url_to_repo"],
							'path' => $project["path"]
						);
						//print checkboxes for git repo's
						printf( '<input type="checkbox" name="check_list[]" value="%1$s">%2$s<br>', $project["id"], $project["name"] );
					}
					printf ( '<input type="submit"/>');


					if(!empty($_POST['check_list'])) {
						foreach($_POST['check_list'] as $check) {
							$foldername = str_replace("-", "_", $projects[$check]['path']);
							$dbname = "{$foldername}_drup";

							//Git clone the projects of checked field
							// > /dev/null 2>/dev/null & makes sure that the website doesn't wait for the script to finish before continueing.
							$output1 = shell_exec("git clone {$projects[$check]['ssh_url_to_repo']} $docrootpath/$foldername");
							echo "<pre>$output1</pre>";

							//Create database for checked field
							$output2 = shell_exec("mysql -uroot -proot -e \"create database $dbname;\"");
							echo "<pre>$output2</pre>";

							//Import correct database from sqldumps folder in documentroot into the just created database
							$output3 = shell_exec("mysql -uroot -proot $dbname < $docrootpath/sqldumps/$dbname.sql");
							echo "<pre>$output3</pre>";

							//Copy settings.php from sqldumps folder in documentroot into project/sites/default
							$output4 = shell_exec("cp $docrootpath/sqldumps/settings.php $docrootpath/$foldername/sites/default/settings.php");
							echo "<pre>$output4</pre>";

							//Replace "DATABASE-NAME" from settings.php to actual database name
							$output5 = shell_exec("sed -i -e 's/DATABASE-NAME/$dbname/g' $docrootpath/$foldername/sites/default/settings.php ");
							echo "<pre>$output5</pre>";

							header("Refresh:0");
						}
					}
					printf('</div>');
				}

				?>

			</content>



		    <footer class="cf">
		    <p></p>
		    </footer>

	    </div>
    </body>
</html>
