<?php
 
    //
    header('Content-Type: application/json');

    //
    require '../vendor/autoload.php';
    require 'v1/functions.php';
    require 'v1/environments.php';

    //
    if(isset($_REQUEST['token'])) {

        //
        if(isset($_REQUEST['app'])) {

            $request['app'] = $_REQUEST['app'];
    
            //
            switch ($_REQUEST['domain']) {

                //
                case 'persons': require 'endpoint-identity-persons.php'; break;
                case 'users': require 'endpoint-identity-users.php'; break;
                case 'profiles': require 'endpoint-identity-profiles.php'; break;
    
                
                //
                case 'signup': require 'endpoint-experience-signup.php'; break;
                case 'signin': require 'endpoint-experience-signin.php'; break;
                case 'payment': require 'endpoint-experience-payment.php'; break;
                case 'products': require 'endpoint-experience-product.php'; break;

                //
                default: header("Location: template-guest-hello.php");
            
            }

        } else { 

            // connect to the PostgreSQL database

            //$data = NULL;
            $code = 401;
            $message = "Forbidden - Valid App ID required";

            $results = array(
                'status' => $code,
                'message' => $message,
                /*
                'data' => $data,
                'log' => [
                    'process' => $process_id = Token::process_id(),
                    'event' => $event_id = Token::event_id($process_id)
                ]*/
            );
            
            $results = json_encode($results);
        
            echo $results;
        
        }

    } else {

        // connect to the PostgreSQL database

        //$data = NULL;
        $code = 401;
        $message = "Forbidden - Valid token required";

        $results = array(
            'status' => $code,
            'message' => $message,
            /*
            'data' => $data,
            'log' => [
                'process' => $process_id = Token::process_id(),
                'event' => $event_id = Token::event_id($process_id)
            ]*/
        );

        $results = json_encode($results);
        
        echo $results;

    }

?>
