<?php

    //
    header('Content-Type: application/json');

    //
    use Core\Connection as Connection;
    use Core\Token as Token;
    use Identity\Person as Person;

    // connect to the PostgreSQL database
    $pdo = Connection::get()->connect();
    
    //
    switch ($_SERVER['REQUEST_METHOD']) {

        //
        case 'POST':

            try {

                // 
                $person = new Person($pdo);
            
                // insert a stock into the stocks table
                $id = $person->insertPerson($_REQUEST);

                echo 'The stock has been inserted with the id ' . $id . '<br>';
            
            } catch (\PDOException $e) {

                echo $e->getMessage();

            }

        break;

        //
        case 'GET':

            try {

                // 
                $person = new Person($pdo);

                // get all stocks data
                $persons = $person->selectPersons($_REQUEST);

                $persons = json_encode($persons);

                echo $persons;

            } catch (\PDOException $e) {

                echo $e->getMessage();

            }

        break;

    }



?>
