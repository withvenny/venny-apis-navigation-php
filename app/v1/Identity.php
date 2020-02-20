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

            //
            $this->pdo = $pdo;

            //
            $this->token = new \Core\Token($this->pdo);

            //
            $this->event_id = new \Core\Token($this->pdo);

            //
            $this->process_id = new \Core\Token($this->pdo);


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

            //$token = new \Core\Token($this->pdo);
            $token = $this->token->validatedToken($request['token']);

            // Retrieve data ONLY if token  
            if($token) {
                
                // domain, app always present

                //
                $conditions = "";
                $domain = $request['domain'];
                $prefix = prefixed($domain);

                //
                if(isset($request['id'])){$id=clean($request['id']);$conditions.="AND ".prefixed($domain)."_id LIKE '%".$id."%' ";}else{$conditions.="";}
                if(isset($request['attributes'])){$attributes=clean($request['attributes']);$conditions.="AND ".prefixed($domain)."_attributes LIKE '%".$attributes."%' ";}else{$conditions.="";}
                if(isset($request['name_first'])){$name_first=clean($request['name_first']);$conditions.="AND ".prefixed($domain)."_name_first LIKE '%".$name_first."%' ";}else{$conditions.="";}
                if(isset($request['name_last'])){$name_last=clean($request['name_last']);$conditions.="AND ".prefixed($domain)."_name_last LIKE '%".$name_last."%' ";}else{$conditions.="";}
                if(isset($request['email'])){$email=clean($request['email']);$conditions.="AND ".prefixed($domain)."_email LIKE '%".$email."%' ";}else{$conditions.="";}
                if(isset($request['phone_primary'])){$phone_primary=clean($request['phone_primary']);$conditions.="AND ".prefixed($domain)."_phone_primary LIKE '%".$phone_primary."%' ";}else{$conditions.="";}
                if(isset($request['phone_secondary'])){$phone_secondary=clean($request['phone_secondary']);$conditions.="AND ".prefixed($domain)."_phone_secondary LIKE '%".$phone_secondary."%' ";}else{$conditions.="";}
                if(isset($request['entitlements'])){$entitlements=clean($request['entitlements']);$conditions.="AND ".prefixed($domain)."_entitlements LIKE '%".$entitlements."%' ";}else{$conditions.="";}

                //
                $columns = "

                    person_id,
                    person_attributes,
                    person_name_first,
                    person_name_middle,
                    person_name_last,
                    person_email,
                    person_phone_primary,
                    person_phone_secondary,
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
                            'name_first' => $row['person_name_first'],
                            'name_middle' => $row['person_name_middle'],
                            'name_last' => $row['person_name_last'],
                            'email' => $row['person_email'],
                            'phone_primary' => $row['person_phone_primary'],
                            'entitlements' => $row['person_entitlements']

                        ];

                    }

                    $code = 200;
                    $message = "OK";

                } else {

                    //
                    $data[] = NULL;
                    $code = 204;
                    $message = "No Content";

                }

            } else {

                //
                $data[] = NULL;
                $code = 401;
                $message = "Forbidden - Valid token required";

            }

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