<?php

	//
	function clean($string) {

		//return htmlentities($string);
		return $string;

	}

	//
	function cleanforsearch($string) {

		if($string == "" || $string == NULL) {

			//echo "Your value is blank.";
			return $string;

		}

		$string = addslashes($string);

		//echo "CLEAN!";
		return urlencode(htmlentities($string));

	}

?>