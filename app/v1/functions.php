<?php

	//
	function clean($string,$type='string') {

		//return htmlentities($string);
		return $string;

    }
    
    // domain to table prefix convertor
	function prefixed($string) {

        if(isset($string)) {
            
            $string = substr($string,0,-1);
        
        }

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