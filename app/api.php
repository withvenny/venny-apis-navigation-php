<?php
 
    //
    header('Content-Type: application/json');

    //
    require '../vendor/autoload.php';
    require 'v1/functions.php';

    //$token = new \Core\Token($this->pdo);
    if(isset($request['token'])) {

        $token = $this->token->validatedToken($request['token']);

        //
        switch ($_REQUEST['domain']) {

            //
            case 'persons': require 'endpoint-identity-persons.php'; break;

            //
            default: header("Location: template-guest-hello.php");
        
        }

    }

?>
