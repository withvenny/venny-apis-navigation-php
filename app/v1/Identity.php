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

        }

        /**
         * insert a new row into the stocks table
         * @param type $symbol
         * @param type $company
         * @return the id of the inserted row
         */
        public function insertPerson($request) {

            $columns = "";
            if(isset($request['id'])){$columns.="person_id,";}
            if(isset($request['attributes'])){$columns.="person_attributes,";}
            if(isset($request['name_first'])){$columns.="person_name_first,";}
            if(isset($request['name_middle'])){$columns.="person_name_middle,";}
            if(isset($request['name_last'])){$columns.="person_name_last,";}
            if(isset($request['email'])){$columns.="person_email,";}
            if(isset($request['phone_primary'])){$columns.="person_phone_primary,";}
            if(isset($request['phone_secondary'])){$columns.="person_phone_secondary,";}
            if(isset($request['entitlements'])){$columns.="person_entitlements,";}
            $columns.= "app_id,";
            $columns.= "event_id,";
            $columns.= "process_id";

            $values = "";
            if(isset($request['id'])){$values.=":person_id,";}
            if(isset($request['attributes'])){$values.=":person_attributes,";}
            if(isset($request['name_first'])){$values.=":person_name_first,";}
            if(isset($request['name_middle'])){$values.=":person_name_middle,";}
            if(isset($request['name_last'])){$values.=":person_name_last,";}
            if(isset($request['email'])){$values.=":person_email,";}
            if(isset($request['phone_primary'])){$values.=":person_phone_primary,";}
            if(isset($request['phone_secondary'])){$values.=":person_phone_secondary,";}
            if(isset($request['entitlements'])){$values.=":person_entitlements,";}
            $values.= ":app_id,";
            $values.= ":event_id,";
            $values.= ":process_id";

            // prepare statement for insert
            $sql = "INSERT INTO {$request['domain']} (";
            $sql.= $columns;
            $sql.= ") VALUES (";
            $sql.= $values;
            $sql.= ")";
    
            //
            $statement = $this->pdo->prepare($sql);
            
            // pass values to the statement
            if(isset($request['id'])){$statement->bindValue('person_id',$request['id']);}
            if(isset($request['attributes'])){$statement->bindValue('person_attributes',$request['attributes']);}
            if(isset($request['name_first'])){$statement->bindValue('person_name_first',$request['name_first']);}
            if(isset($request['name_middle'])){$statement->bindValue('person_name_middle',$request['name_middle']);}
            if(isset($request['name_last'])){$statement->bindValue('person_name_last',$request['name_last']);}
            if(isset($request['email'])){$statement->bindValue('person_email',$request['email']);}
            if(isset($request['phone_primary'])){$statement->bindValue('person_phone_primary',$request['phone_primary']);}
            if(isset($request['phone_secondary'])){$statement->bindValue('person_phone_secondary',$request['phone_secondary']);}
            if(isset($request['entitlements'])){$statement->bindValue('person_entitlements',$request['entitlements']);}
            $statement->bindValue(':app_id', $request['app']);
            $statement->bindValue(':event_id', $this->token->event_id());
            $statement->bindValue(':process_id', $this->token->process_id());
            
            // execute the insert statement
            $statement->execute();

            //
            if($statement->rowCount() > 0) {
                
                $data = $statement->fetchObject(\PDO::FETCH_ASSOC);

                echo var_dump($data);

                return $data;

            } else {

                //
                echo 'No data in your DATABASE...';

            }

            // return generated id
            //return $this->pdo->lastInsertId('persons_sequence');
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
                    $data = array();
                
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
                    $data = NULL;
                    $code = 204;
                    $message = "No Content";

                }

            } else {

                //
                $data[] = NULL;
                $code = 401;
                $message = "Forbidden - Valid token required";

            }

            $results = array(

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
                ]

            );

            //
            return $results;

        }

        /**
         * Find stock by id
         * @param int $id
         * @return a stock object
         */
        public function updatePerson($request) {

            //
            $domain = $request['domain'];
            $table = prefixed($domain);
            $id = $request['id'];

            //
            $set = "";
            //if(isset($request['id'])){$set.= " person_id = :person_id, ";}
            if(isset($request['attributes'])){$set.= " person_attributes = :person_attributes ";}
            if(isset($request['name_first'])){$set.= " person_name_first = :person_name_first ";}
            if(isset($request['name_middle'])){$set.= " person_name_middle = :person_name_middle ";}
            if(isset($request['name_last'])){$set.= " person_name_last = :person_name_last ";}
            if(isset($request['email'])){$set.= " person_email = :person_email ";}
            if(isset($request['phone_primary'])){$set.= " person_phone_primary = :person_phone_primary ";}
            if(isset($request['phone_secondary'])){$set.= " person_phone_secondary = :person_phone_secondary ";}
            if(isset($request['entitlements'])){$set.= " person_entitlements = :person_entitlements ";}

            //
            $set = str_replace('  ',',',$set);

            // GET table name
            $condition = $table."_id = :id";

            //echo json_encode($set);
            //echo json_encode($condition);
            //exit;

            /**
             * Update stock based on the specified id
             * @param int $id
             * @param string $symbol
             * @param string $company
             * @return int
             */

            // sql statement to update a row in the stock table
            $sql = "UPDATE {$domain} SET ";
            $sql.= $set;
            $sql.= " WHERE ";
            $sql.= $condition;

            //echo $sql; exit;

            $statement = $this->pdo->prepare($sql);
    
            // bind values to the statement
            //if(isset($request['id'])){$statement->bindValue(':person_id', $request['id']);}
            if(isset($request['attributes'])){$statement->bindValue(':person_attributes', $request['attributes']);}
            if(isset($request['name_first'])){$statement->bindValue(':person_name_first', $request['name_first']);}
            if(isset($request['name_middle'])){$statement->bindValue(':person_name_middle', $request['name_middle']);}
            if(isset($request['name_last'])){$statement->bindValue(':person_name_last', $request['name_last']);}
            if(isset($request['email'])){$statement->bindValue(':person_email', $request['email']);}
            if(isset($request['phone_primary'])){$statement->bindValue(':person_phone_primary', $request['phone_primary']);}
            if(isset($request['phone_secondary'])){$statement->bindValue(':person_phone_secondary', $request['phone_secondary']);}
            if(isset($request['entitlements'])){$statement->bindValue(':person_entitlements', $request['entitlements']);}

            //if(isset($request['id'])){$statement->bindValue(':person_entitlements', $request['entitlements']);}
            $statement->bindValue(':id', $id);

            // update data in the database
            $statement->execute();

            // return the number of row affected
            return $statement->rowCount();
            //return $this->pdo->lastInsertId('persons_sequence');

        }

        /**
         * Delete a row in the stocks table specified by id
         * @param int $id
         * @return the number row deleted
         */
        public function deletePerson($request) {

            $id = $request['id'];
            $domain = $request['domain'];
            $column = prefixed($domain) . '_id';
            $sql = 'DELETE FROM ' . $domain . ' WHERE '.$column.' = :id';
            //echo $id; //exit
            //echo $column; //exit;
            //echo $domain; //exit;
            //echo $sql; //exit

            $statement = $this->pdo->prepare($sql);
            //$statement->bindParam(':column', $column);
            $statement->bindValue(':id', $id);
            $statement->execute();
            return $statement->rowCount();

        }

    }

?>