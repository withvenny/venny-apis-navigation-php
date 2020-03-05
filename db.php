<?php

	//
	$timezone = date_default_timezone_set("America/New_York");

	// Determine scope...
	if ($_SERVER['HTTP_HOST'] == 'localhost') {

		define ('APP_NAME',     'Notearise'); // app
		define ('APP_ENV',      'STAGING'); // app environment
		define ('APP_ENV_SRVR', 'https://localhost/'); // Site path
		define ('APP_ST_NAME',  'www.notearise.com/');
		define ('APP_ST_URL',   APP_ENV_SRVR . APP_ST_NAME); // host
		define ('APP_ST_CDN',	  APP_ST_URL . 'assets/');//notearise.imgix.net/');  in PROD // include path
		define ('APP_IN_PATH',  'apps/notearise-web/'); // include path
		define ('APP_DB_HOST',  '127.0.0.1'); // db hostname
		define ('APP_DB_PORT',  '3306'); // db port
		define ('APP_DB_NAME',  'notearise'); // db name
		define ('APP_DB_USER',  'root'); // db username
		define ('APP_DB_PASS',  'B1@thering!'); // db password

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

		define ('APP_NAME',     'Notearise'); // app environment
		define ('APP_ENV',      'PRODUCTION'); // app environment
		define ('APP_ENV_SRVR', 'http://'); // Site path
		define ('APP_ST_NAME',  'www.notearise.com/');
		define ('APP_ST_URL',   APP_ENV_SRVR . APP_ST_NAME); // host
		define ('APP_ST_CDN',	  'https://notearise.imgix.net/'); // include path
		define ('APP_IN_PATH',  'apps/notearise-web/'); // include path
		define ('APP_DB_HOST',  'us-cdbr-iron-east-05.cleardb.net'); // Clear MySQL db hostname
		define ('APP_DB_PORT',  '3307'); // Clear MySQL db port
		define ('APP_DB_NAME',  'heroku_2742d2169f9d7eb'); // Clear MySQL db name
		define ('APP_DB_USER',  'b4165579b8ace4'); // Clear MySQL db username
		define ('APP_DB_PASS',  'de859eea'); // Clear MySQL db password

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

	$con = mysqli_connect(APP_DB_HOST,APP_DB_USER,APP_DB_PASS,APP_DB_NAME); //Connection variable

	//$con = mysqli_connect('us-cdbr-iron-east-05.cleardb.net/heroku_ccfc4a770bc3c0b?reconnect=true','be2eb965a50c39','5d98e8e7','heroku_ccfc4a770bc3c0b');
	if(mysqli_connect_errno()) {

		echo "Failed to connect: " . mysqli_connect_errno();

	}

	// Timezone
	$timezone = date_default_timezone_set("America/New_York");

	//
	function row_count($result) {

		return mysqli_num_rows($result);

	}

	//
	function escape($string) {

		global $con;

		return mysqli_real_escape_string($con, $string);

	}

	//
	function confirm($result) {

		global $con;

		if(!$result) {

			die("QUERY FAILED" . mysqli_error($con));

		}

	}

	//
	function query($query) {

		global $con;

		$result = mysqli_query($con, $query);

		confirm($result);

		return $result;

	}

	//
	function fetch_array($result) {

		global $con;

		return mysqli_fetch_array($result);

	}

 ?>
