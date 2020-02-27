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
    if(isset($_REQUEST['name_first'])){$request['name_first'] = clean($_REQUEST['name_first']);}
    if(isset($_REQUEST['email'])){$request['email'] = clean($_REQUEST['email']);}
    if(isset($_REQUEST['authorize'])){$request['authorize'] = clean($_REQUEST['authorize']);}

    //
    if($_SERVER['REQUEST_METHOD']=='POST'){

        try {

            // 
            $profile = new Profile($pdo);
            $person = new Person($pdo);
            $user = new User($pdo);

            /*
            name_first
            name_last
            email
            access
            */
        
            // insert a person and get person ID
            $request['domain'] = 'persons';
            $person_id = $person->insertPerson($request);

            // add new person ID to overall request
            $request['id'] = $person_id;

            // get person ID's details
            $person_details = $person->selectPersons($request);

            // insert a user and get user ID
            $request['domain'] = 'users';
            $user_id = $user->insertUser($request);

            // add new person ID to overall request
            $request['id'] = $user_id;

            // get person ID's details
            $user_details = $user->selectUsers($request);

            // insert a profile and get profile ID
            $request['domain'] = 'profiles';
            $profile_id = $profile->insertProfile($request);

            // add new person ID to overall request
            $request['id'] = $profile_id;

            // get person ID's details
            $profile_details = $profile->selectProfiles($request);
            
            //
            echo $results;
        
        } catch (\PDOException $e) {

            echo $e->getMessage();

        }

    }

?>
