<?php

    //
    header('Content-Type: application/json');

    //
    use Core\Connection as Connection;
    use Core\Token as Token;
    use Identity\Person as Person;

    // connect to the PostgreSQL database
    $pdo = Connection::get()->connect();

    // STEP 1. Receive passed variables / information
    if(isset($_REQUEST['app'])){$request['app'] = clean($_REQUEST['app']);}
    if(isset($_REQUEST['domain'])){$request['domain'] = clean($_REQUEST['domain']);}
    if(isset($_REQUEST['token'])){$request['token'] = clean($_REQUEST['token']);}

    // data cleanse
    if(isset($_REQUEST['id'])){$request['id'] = clean($_REQUEST['id']);}
    if(isset($_REQUEST['attributes'])){$request['attributes'] = clean($_REQUEST['attributes']);}
    if(isset($_REQUEST['name_first'])){$request['name_first'] = clean($_REQUEST['name_first']);}
    if(isset($_REQUEST['name_middle'])){$request['name_middle'] = clean($_REQUEST['name_middle']);}
    if(isset($_REQUEST['name_last'])){$request['name_last'] = clean($_REQUEST['name_last']);}
    if(isset($_REQUEST['email'])){$request['email'] = clean($_REQUEST['email']);}
    if(isset($_REQUEST['phone_primary'])){$request['phone_primary'] = clean($_REQUEST['phone_primary']);}
    if(isset($_REQUEST['phone_secondary'])){$request['phone_secondary'] = clean($_REQUEST['phone_secondary']);}
    if(isset($_REQUEST['entitlements'])){$request['entitlements'] = clean($_REQUEST['entitlements']);}

    //
    switch ($_SERVER['REQUEST_METHOD']) {

        //
        case 'POST':

            try {

                // 
                $person = new Person($pdo);
            
                // insert a stock into the stocks table
                $id = $person->insertPerson($request);

                echo 'The record ' . $id . ' has been inserted';
            
            } catch (\PDOException $e) {

                echo $e->getMessage();

            }

        break;

        //
        case 'GET':

            //
            if(isset($_REQUEST['per'])){$request['per'] = clean($_REQUEST['per']);}
            if(isset($_REQUEST['page'])){$request['page'] = clean($_REQUEST['page']);}
            if(isset($_REQUEST['limit'])){$request['limit'] = clean($_REQUEST['limit']);}        

            try {

                // 
                $person = new Person($pdo);

                // get all stocks data
                $persons = $person->selectPersons($request);

                $persons = json_encode($persons);

                echo $persons;

            } catch (\PDOException $e) {

                echo $e->getMessage();

            }

        break;

        //
        case 'PUT':

            try {

                // 
                $person = new Person($pdo);
            
                // insert a stock into the stocks table
                $id = $person->updatePerson($request);

                echo 'The record ' . $id . ' has been updated';
            
            } catch (\PDOException $e) {

                echo $e->getMessage();

            }

        break;

        //
        case 'DELETE':

            try {

                // 
                $person = new Person($pdo);
            
                // insert a stock into the stocks table
                $id = $person->deletePerson($request);

                echo 'The record ' . $id . ' has been deleted';
            
            } catch (\PDOException $e) {

                echo $e->getMessage();

            }

        break;

    }

?>
