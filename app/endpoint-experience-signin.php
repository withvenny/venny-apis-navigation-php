<?php

    //
    header('Content-Type: application/json');

    //
    use Core\Connection as Connection;
    use Core\Token as Token;
    use Identity\Profile as Profile;
    use Identity\Person as Person;
    use Identity\User as User;

    // connect to the PostgreSQL database
    $pdo = Connection::get()->connect();

    // STEP 1. Receive passed variables / information
    if(isset($_REQUEST['app'])){$request['app'] = clean($_REQUEST['app']);}
    if(isset($_REQUEST['domain'])){$request['domain'] = clean($_REQUEST['domain']);}
    if(isset($_REQUEST['token'])){$request['token'] = clean($_REQUEST['token']);}

    /*
    if (empty($_REQUEST['email']) || empty($_REQUEST['firstName']) || empty($_REQUEST['lastName']) || 
    empty($_REQUEST['password']) || empty($_REQUEST['birthday']) || empty($_REQUEST['gender'])) {
    */

    // data cleanse
    if(isset($_REQUEST['email'])){$request['email'] = clean($_REQUEST['email']);}
    if(isset($_REQUEST['authorize'])){$request['authorize'] = clean($_REQUEST['authorize']);}
    //if(isset($_REQUEST['alias'])){$request['alias'] = clean($_REQUEST['alias']);}

    //
    if($_SERVER['REQUEST_METHOD']=='POST') {

        //echo json_encode($_REQUEST);exit;

        try {

            // 
            $profile = new Profile($pdo);
            $person = new Person($pdo);
            $user = new User($pdo);
            $token = new Token($pdo);

            //
            // get person ID's details
            $person_details = $person->selectPersons($request);

            //
            $request['person'] = $person_details['data'][0]['id'];

            // get person ID's details
            $user_details = $user->selectUsers($request);

            //echo json_encode($user_details) . '<br/>';exit;

            // insert a profile and get profile ID
            $request['user'] = $user_details['data'][0]['id'];

            //
            $request['domain'] = 'profiles';

            //
            $profile_details = $profile->selectProfiles($request);

            //
            $results['status'] = 200;
            $results['message'] = 'SUCCESSFULL';
            $data = json_encode(array_merge($person_details['data'],$user_details['data'],$profile_details['data']));
            $results['data']=$data;
            
            //$results['data']=array();
            //$results['data'].=$person_details['data'];
            //$results['data'].=$user_details['data'];
            //$results['data'].=$profile_details['data'];
            
            $results['log'] = [
                'process' => $process_id = $token->process_id(),
                'event' => $token->event_id($process_id)
            ];

            //
            $results = json_encode($results);

            echo $results;
        
        } catch (\PDOException $e) {

            echo $e->getMessage();

        }

    }

?>
