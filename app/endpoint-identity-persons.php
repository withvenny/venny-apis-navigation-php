<?php

    //
    header('Content-Type: application/json');

    //
    use Core\Connection as Connection;
    use Identity\Person as Person;

    //
    if(isset($_REQUEST['token'])) {

        //
        if(isset($_REQUEST['app_id'])) {
 
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

        } else { 

            $data[] = NULL;
            $code = 401;
            $message = "Forbidden - Valid token required";

            $results[] = [
                'status' => $code,
                'message' => $message,
                'metadata' => [
                    'page' => $request['page'],
                    'pages' => $pages,
                    'total' => $total
                ],
                'data' => $data,
                'log' => [
                    'process' => $process_id = $this->token->process_id(),
                    'event' => $event_id = $this->token->event_id($process_id)
                ],
            ];
            
            echo json_encode($results);
        
        }

    }

?>
