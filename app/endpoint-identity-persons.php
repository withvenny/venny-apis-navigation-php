<?php

    //
    use Core\Connection as Connection;
    use Identity\Person as Person;
 
    //
    switch ($_SERVER['REQUEST_METHOD']) {

        //
        case 'POST':

            try {

                // connect to the PostgreSQL database
                $pdo = Connection::get()->connect();

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

                // connect to the PostgreSQL database
                $pdo = Connection::get()->connect();

                // 
                $person = new Person($pdo);

                // get all stocks data
                $persons = $person->selectPersons($_REQUEST);

                echo json_encode($persons);

            } catch (\PDOException $e) {

                echo $e->getMessage();

            }

        break;

    }

?>
