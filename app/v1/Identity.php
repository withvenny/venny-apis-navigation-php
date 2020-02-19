<?php

    namespace Identity;

    /**
     * Represent the table data insertion
     */
    class Person {

        /**
         * PDO object
         * @var \PDO
         */
        private $pdo;
    
        /**
         * init the object with a \PDO object
         * @param type $pdo
         */
        public function __construct($pdo) {
            $this->pdo = $pdo;
        }

        /**
         * insert a new row into the stocks table
         * @param type $symbol
         * @param type $company
         * @return the id of the inserted row
         */

        public function insertPerson($request) {

            // prepare statement for insert
            $sql = 'INSERT INTO persons (
                person_id,
                person_attributes,
                person_first_name,
                person_last_name,
                person_email,
                person_phone,
                person_entitlements,
                app_id,
                event_id,
                process_id
            ) VALUES (
                :person_id,
                :person_attributes,
                :person_first_name,
                :person_last_name,
                :person_email,
                :person_phone,
                :person_entitlements,
                :app_id,
                :event_id,
                :process_id
            )';
    
            //
            $statement = $this->pdo->prepare($sql);
            
            // pass values to the statement
            $statement->bindValue(':person_id', $request['id']);
            $statement->bindValue(':person_attributes', $request['attributes']);
            $statement->bindValue(':person_first_name', $request['first_name']);
            $statement->bindValue(':person_last_name', $request['last_name']);
            $statement->bindValue(':person_email', $request['email']);
            $statement->bindValue(':person_phone', $request['phone']);
            $statement->bindValue(':person_entitlements', $request['entitlements']);
            $statement->bindValue(':app_id', $request['app_id']);
            $statement->bindValue(':event_id', $request['event_id']);
            $statement->bindValue(':process_id', $request['process_id']);
            
            // execute the insert statement
            $statement->execute();

            //
            if($statement->rowCount() > 0) {
                //
                $data = [];
            
                //
                while($row = $statement->fetch(\PDO::FETCH_ASSOC)) {
    
                    //
                    $data[] = [

                        'id' => $row['person_id'],
                        'attributes' => $row['person_attributes'],
                        'first_name' => $row['person_first_name'],
                        'last_name' => $row['person_last_name'],
                        'email' => $row['person_email'],
                        'phone' => $row['person_phone'],
                        'entitlements' => $row['person_entitlements']
                    ];

                }

            } else {

                //
                echo 'No data in your DATABASE...';

            }

            // return generated id
            return $this->pdo->lastInsertId('persons_sequence');
            //return $this->pdo->selectPersons('persons_sequence');
        }

        /**
        * Return all rows in the stocks table
        * @return array
        */
        public function selectPersons($request) {

            $token = new Token();
            $checked = $token->checkToken($request['token']);

            // domain, app always present

            //
            $conditions = "";
            $domain = $request['domain'];
            $prefix = prefixed($domain);

            //
            if(isset($request['id'])){$id=clean($request['id']);$conditions.="AND ".substr($domain,0,-1)."_id LIKE '%".$id."%' ";}else{$conditions.="";}

            $columns = "

                person_id,
                person_attributes,
                person_first_name,
                person_last_name,
                person_email,
                person_phone,
                person_entitlements

            ";

            $table = $domain;

            //
            $start = 0;

            //
            if(isset($request['page'])) {

                //
                $start = ($request['page'] - 1) * $request['per'];
            
            }

            //
            if(!empty($request['id'])) {

                $conditions = " WHERE";
                $conditions.= " " . $prefix . "_id = :id ";
                $conditions.= " AND active = 1 ";
                $conditions.= " ORDER BY time_finished DESC ";
                
                $subset = " LIMIT 1";

                $sql = "SELECT ";
                $sql.= $columns;
                $sql.= " FROM " . $table;
                $sql.= $conditions;
                $sql.= $subset;
                
                //echo $sql; exit;

                //
                $statement = $this->pdo->prepare($sql);

                // bind value to the :id parameter
                $statement->bindValue(':id', $request['id']);

                //echo $sql; exit;

            } else {

                $conditions = " WHERE ";
                $conditions.= " active = 1 ";
                $conditions.= " ORDER BY time_finished DESC ";
                $subset = " OFFSET {$start}" . " LIMIT {$request['per']}";

                $sql = "SELECT ";
                $sql.= $columns;
                $sql.= "FROM " . $table;
                $sql.= $conditions;
                $sql.= $subset;
                
                //
                $statement = $this->pdo->prepare($sql);

            }
                
            // execute the statement
            $statement->execute();

            //
            $results = [];
            $total = $statement->rowCount();
            $pages = ceil($total/$request['per']); //
            //$current = 1; // current page
            //$limit = $result['limit'];
            //$max = $result['max'];

            //
            if($statement->rowCount() > 0) {

                //
                $data = [];
            
                //
                while($row = $statement->fetch(\PDO::FETCH_ASSOC)) {
    
                    //
                    $data[] = [

                        'id' => $row['person_id'],
                        'attributes' => $row['person_attributes'],
                        'first_name' => $row['person_first_name'],
                        'last_name' => $row['person_last_name'],
                        'email' => $row['person_email'],
                        'phone' => $row['person_phone'],
                        'entitlements' => $row['person_entitlements']
                    ];

                }

            } else {

                //
                echo 'No data in your DATABASE...';

            }

            $results[] = [
                'status' => 200,
                'message' => 'Successful',
                'metadata' => [
                    'page' => $request['page'],
                    'pages' => $pages,
                    'total' => $total
                ],
                'data' => $data,
                'log' => [
                    'event' => substr(md5(uniqid(microtime(true),true)),0,13),
                    'process' => substr(md5(uniqid(microtime(true),true)),0,13)
                ],
            ];

            //echo " results ";
            //echo json_encode($results);

            //
            return $results;

        }

        /**
         * Find stock by id
         * @param int $id
         * @return a stock object
         */
        public function findByPK($id) {
            // prepare SELECT statement
            $statement = $this->pdo->prepare('SELECT id, symbol, company
                                        FROM stocks
                                        WHERE id = :id');
            // bind value to the :id parameter
            $stmt->bindValue(':id', $id);
            
            // execute the statement
            $stmt->execute();
    
            // return the result set as an object
            return $stmt->fetchObject();
        }

    }

?>