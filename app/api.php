<?php
 
    //
    header('Content-Type: application/json');

    //
    require '../vendor/autoload.php';
    require 'v1/functions.php';

    //
    switch ($_REQUEST['domain']) {

        //
        case 'persons': require 'endpoint-persons.php'; break;

        //
        default: header("Location: template-guest-hello.php");
    
    }

?>
