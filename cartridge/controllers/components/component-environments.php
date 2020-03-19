<?php

	//
	$timezone = date_default_timezone_set("America/New_York");

  // Determine scope...
  if($_SERVER['HTTP_HOST'] == 'localhost') {

    //
    $app = parse_ini_file('../../../app.ini');
    //echo var_dump($app); //exit;

    //
    define ('APP_ENV_ROOT', $app['test_env_root']); // app environment root
    define ('APP_ST_NAME',  $app['test_st_name']); // app site name
    define ('APP_NAME',     $app['test_app_name']); // app
    define ('APP_ENV',      $app['test_app_env']); // app environment
    define ('APP_ENV_SRVR', 'http://localhost/'); // Site path
    define ('APP_ST_ALIS',  APP_ST_NAME);
		define ('APP_ST_URL',   APP_ENV_SRVR . APP_ST_NAME); // host
    define ('APP_ST_INCL',  'apps/v1/'); // include path
		define ('APP_ST_UPLD',  '_assets/images/'); // directory for all image uploads
    define ('APP_ST_CDN',   'http://venny-cdn.imgix.net/'); // directory for all image uploads
		define ('APP_DB_URL',   $app['test_db_url']); // db hostname
	  define ('APP_API_KEY',  $app['test_app_token']); // API key used for all intraapp API calls
    define ('APP_EM_FROM',  $app['test_em_from']); // app
    define ('APP_EM_HOST',  $app['test_em_host']); // Mailgun hostname
    define ('APP_EM_KEY',   $app['test_em_key']); // Private API Key
    define ('APP_GG_TAG',   'UA-116723436-1'); // Google Tag Manager ID

		/*

    echo 'ENV: ' . APP_ENV . '<br/>';
    echo 'APP_DB_HOST: ' . APP_DB_HOST . '<br/>';
    echo 'APP_DB_PORT: ' . APP_DB_PORT . '<br/>';
    echo 'APP_DB_NAME: ' . APP_DB_NAME . '<br/>';
    echo 'APP_DB_USER: ' . APP_DB_USER . '<br/>';
    echo 'APP_DB_PASS: ' . APP_DB_PASS . '<br/>';

		echo "DOCUMENT_ROOT: " . $_SERVER['DOCUMENT_ROOT'] . "<br/>";
		echo "PHP_SELF: " . $_SERVER['PHP_SELF'] . "<br/>";
		echo "SCRIPT_FILENAME: " . $_SERVER["SCRIPT_FILENAME"] . "<br/>";
		echo "SERVER_ADMIN: " . $_SERVER["SERVER_ADMIN"] . "<br/>";
		echo "SERVER_NAME: " . $_SERVER["SERVER_NAME"] . "<br/>";
		echo "SERVER_ADDR: " . $_SERVER["SERVER_ADDR"] . "<br/>";
		echo "SERVER_NAME: " . $_SERVER["SERVER_NAME"] . "<br/>";
		echo "include_path:" . get_include_path() . "<br/>";

		*/

  }

  else {

    //
    $app = parse_ini_file('../../../app.ini');
    //echo var_dump($app); exit;

    //
    define ('APP_ENV_ROOT', $app['live_env_root']); // app environment root
    define ('APP_ST_NAME',  $app['live_st_name']); // app site name
    define ('APP_NAME',     getenv('APP_NAME')); // app
    define ('APP_ENV',      getenv('APP_ENV')); // app environment
    define ('APP_ENV_SRVR', 'http://localhost/'); // Site path
    define ('APP_ST_ALIS',  APP_ST_NAME);
		define ('APP_ST_URL',   APP_ENV_SRVR . APP_ST_NAME); // host
    define ('APP_ST_INCL',  'apps/v1/'); // include path
		define ('APP_ST_UPLD',  '_assets/images/'); // directory for all image uploads
    define ('APP_ST_CDN',   'http://venny-cdn.imgix.net/'); // directory for all image uploads
		define ('APP_DB_URL',   getenv('DATABASE_URL')); // db hostname
	  define ('APP_API_KEY',  $app['live_app_token']); // API key used for all intraapp API calls
    define ('APP_EM_FROM',  $app['live_em_from']); // app
    define ('APP_EM_HOST',  $app['live_em_host']); // Mailgun hostname
    define ('APP_EM_KEY',   $app['live_em_key']); // Private API Key
    define ('APP_GG_TAG',   'UA-116723436-1'); // Google Tag Manager ID
		/*

		echo 'ENV: ' . APP_ENV . '<br/>';
    echo 'APP_DB_HOST: ' . APP_DB_HOST . '<br/>';
    echo 'APP_DB_PORT: ' . APP_DB_PORT . '<br/>';
    echo 'APP_DB_NAME: ' . APP_DB_NAME . '<br/>';
    echo 'APP_DB_USER: ' . APP_DB_USER . '<br/>';
    echo 'APP_DB_PASS: ' . APP_DB_PASS . '<br/>';

		echo "DOCUMENT_ROOT: " . $_SERVER['DOCUMENT_ROOT'] . "<br/>";
		echo "PHP_SELF: " . $_SERVER['PHP_SELF'] . "<br/>";
		echo "SCRIPT_FILENAME: " . $_SERVER["SCRIPT_FILENAME"] . "<br/>";
		echo "SERVER_ADMIN: " . $_SERVER["SERVER_ADMIN"] . "<br/>";
		echo "SERVER_NAME: " . $_SERVER["SERVER_NAME"] . "<br/>";
		echo "SERVER_ADDR: " . $_SERVER["SERVER_ADDR"] . "<br/>";
		echo "SERVER_NAME: " . $_SERVER["SERVER_NAME"] . "<br/>";
		echo "include_path:" . get_include_path() . "<br/>";

    */
    
    //echo var_dump($app); //exit;
    //echo var_dump(APP_DB_URL); //exit;


  }

?>
