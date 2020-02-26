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
            $sql.= " RETURNING " . prefixed($request['domain']) . "_id";
    
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

            $data = $statement->fetchAll();
            
            //echo json_encode($data);
            //echo json_encode($data);
            //echo json_encode($data[0]);
            //echo json_encode($data[0]['person_id']);
            $data = $data[0]['person_id'];

            return $data;

            // return generated id
            //return $this->pdo->lastInsertId('persons_sequence');
            //return $this->pdo->selectPersons('persons_sequence');
        
        }

        /**
        * Return all rows in the stocks table
        * @return array
        */
        public function selectPersons($request) {

            //echo json_encode($request); exit;

            //$token = new \Core\Token($this->pdo);
            $token = $this->token->validatedToken($request['token']);

            // Retrieve data ONLY if token  
            if($token) {
                
                // domain, app always present
                if(!isset($request['per'])){$request['per']=20;}
                if(!isset($request['page'])){$request['page']=1;}
                if(!isset($request['limit'])){$request['limit']=100;}
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

                    $conditions.= " WHERE";
                    $conditions.= " " . $prefix . "_id = :id ";
                    $conditions.= " AND active = 1 ";
                    $conditions.= " ORDER BY time_finished DESC ";
                    
                    $subset = " LIMIT 1";

                    $sql = "SELECT ";
                    $sql.= $columns;
                    $sql.= " FROM " . $table;
                    $sql.= $conditions;
                    $sql.= $subset;
                    
                    //echo json_encode($request['id']);
                    //echo '<br/>';
                    //echo $sql; exit;

                    //
                    $statement = $this->pdo->prepare($sql);

                    // bind value to the :id parameter
                    $statement->bindValue(':id', $request['id']);

                    //echo $sql; exit;

                } else {

                    $conditions = "";
                    $refinements = "";
                    if(isset($request['id'])){$refinements.="person_id"." ILIKE "."'%".$request['id']."%' AND ";}
                    if(isset($request['attributes'])){$refinements.="person_attributes"." ILIKE "."'%".$request['attributes']."%' AND ";}
                    if(isset($request['name_first'])){$refinements.="person_name_first"." ILIKE "."'%".$request['name_first']."%' AND ";}
                    if(isset($request['name_middle'])){$refinements.="person_name_middle"." ILIKE "."'%".$request['name_middle']."%' AND ";}
                    if(isset($request['name_last'])){$refinements.="person_name_last"." ILIKE "."'%".$request['name_last']."%' AND ";}
                    if(isset($request['email'])){$refinements.="person_email"." ILIKE "."'%".$request['email']."%' AND ";}
                    if(isset($request['phone_primary'])){$refinements.="person_phone_primary"." ILIKE "."'%".$request['phone_primary']."%' AND ";}
                    if(isset($request['phone_secondary'])){$refinements.="person_phone_secondary"." ILIKE "."'%".$request['phone_secondary']."%' AND ";}
                    if(isset($request['entitlements'])){$refinements.="person_entitlements"." ILIKE "."'%".$request['entitlements']."%' AND ";}
                    
                    //echo $conditions . 'conditions1<br/>';
                    //echo $refinements . 'refinements1<br/>';
                    
                    $conditions.= " WHERE ";
                    $conditions.= $refinements;
                    $conditions.= " active = 1 ";
                    $conditions.= " ORDER BY time_finished DESC ";
                    $subset = " OFFSET {$start}" . " LIMIT {$request['per']}";
                    $sql = "SELECT ";
                    $sql.= $columns;
                    $sql.= "FROM " . $table;
                    $sql.= $conditions;
                    $sql.= $subset;

                    //echo $conditions . 'conditions2<br/>';
                    //echo $refinements . 'refinements2<br/>';

                    //echo $sql; exit;
                    
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
                            'attributes' => json_decode($row['person_attributes']),
                            'name_first' => $row['person_name_first'],
                            'name_middle' => $row['person_name_middle'],
                            'name_last' => $row['person_name_last'],
                            'email' => $row['person_email'],
                            'phone_primary' => $row['person_phone_primary'],
                            'entitlements' => json_decode($row['person_entitlements'])

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
            if(isset($request['id'])){$set.= " person_id = :person_id ";}
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
            $condition.= " RETURNING " . $table . "_id";

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
            if(isset($request['id'])){$statement->bindValue(':person_id', $request['id']);}
            if(isset($request['attributes'])){$statement->bindValue(':person_attributes', $request['attributes']);}
            if(isset($request['name_first'])){$statement->bindValue(':person_name_first', $request['name_first']);}
            if(isset($request['name_middle'])){$statement->bindValue(':person_name_middle', $request['name_middle']);}
            if(isset($request['name_last'])){$statement->bindValue(':person_name_last', $request['name_last']);}
            if(isset($request['email'])){$statement->bindValue(':person_email', $request['email']);}
            if(isset($request['phone_primary'])){$statement->bindValue(':person_phone_primary', $request['phone_primary']);}
            if(isset($request['phone_secondary'])){$statement->bindValue(':person_phone_secondary', $request['phone_secondary']);}
            if(isset($request['entitlements'])){$statement->bindValue(':person_entitlements', $request['entitlements']);}
            $statement->bindValue(':id', $id);

            // update data in the database
            $statement->execute();

            $data = $statement->fetchAll();
            
            $data = $data[0]['person_id'];

            // return generated id
            return $data;

            // return the number of row affected
            //return $statement->rowCount();

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

    /**
     * Represent the table data insertion
     */
    class User {

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
        public function insertUser($request) {

            $columns = "";
            if(isset($request['access'])){$columns.="user_access,";}

            if(isset($request['id'])){$columns.="user_id,";}		
            if(isset($request['attributes'])){$columns.="user_attributes,";}		
            if(isset($request['alias'])){$columns.="user_alias,";}		
            if(isset($request['lastlogin'])){$columns.="user_lastlogin,";}		
            if(isset($request['status'])){$columns.="user_status,";}		
            if(isset($request['validation'])){$columns.="user_validation,";}		
            if(isset($request['welcome'])){$columns.="user_welcome,";}		
            $columns.= "app_id,";
            $columns.= "event_id,";
            $columns.= "process_id";

            $values = "";
            //if(isset($request['access'])){$values.=":user_access,";}		

            if(isset($request['id'])){$values.=":user_id,";}		
            if(isset($request['attributes'])){$values.=":user_attributes,";}		
            if(isset($request['alias'])){$values.=":user_alias,";}		
            if(isset($request['lastlogin'])){$values.=":user_lastlogin,";}		
            if(isset($request['status'])){$values.=":user_status,";}		
            if(isset($request['validation'])){$values.=":user_validation,";}		
            if(isset($request['welcome'])){$values.=":user_welcome,";}		
            $values.= ":app_id,";
            $values.= ":event_id,";
            $values.= ":process_id";

            // prepare statement for insert
            $sql = "INSERT INTO {$request['domain']} (";
            $sql.= $columns;
            $sql.= ") VALUES (";
            $sql.= "crypt('".$request['access']."', gen_salt('bf'))";
            $sql.= $values;
            $sql.= ")";
            $sql.= " RETURNING " . prefixed($request['domain']) . "_id";

            echo $sql;exit;
    
            //
            $statement = $this->pdo->prepare($sql);
            
            // pass values to the statement
            if(isset($request['id'])){$statement->bindValue('user_id',$request['id']);}		
            if(isset($request['attributes'])){$statement->bindValue('user_attributes',$request['attributes']);}		
            if(isset($request['alias'])){$statement->bindValue('user_alias',$request['alias']);}		
            if(isset($request['access'])){$statement->bindValue('user_access',$request['access']);}		
            if(isset($request['lastlogin'])){$statement->bindValue('user_lastlogin',$request['lastlogin']);}		
            if(isset($request['status'])){$statement->bindValue('user_status',$request['status']);}		
            if(isset($request['validation'])){$statement->bindValue('user_validation',$request['validation']);}		
            if(isset($request['welcome'])){$statement->bindValue('user_welcome',$request['welcome']);}		
            if(isset($request[''])){$statement->bindValue('',$request['']);}		
            if(isset($request[''])){$statement->bindValue('',$request['']);}		
            if(isset($request[''])){$statement->bindValue('',$request['']);}		
            $statement->bindValue(':app_id', $request['app']);
            $statement->bindValue(':event_id', $this->token->event_id());
            $statement->bindValue(':process_id', $this->token->process_id());
            
            // execute the insert statement
            $statement->execute();

            $data = $statement->fetchAll();
            
            //echo json_encode($data);
            //echo json_encode($data);
            //echo json_encode($data[0]);
            //echo json_encode($data[0]['person_id']);
            $data = $data[0]['person_id'];

            return $data;

            // return generated id
            //return $this->pdo->lastInsertId('persons_sequence');
            //return $this->pdo->selectPersons('persons_sequence');
        
        }

        /**
        * Return all rows in the stocks table
        * @return array
        */
        public function selectUsers($request) {

            //echo json_encode($request); exit;

            //$token = new \Core\Token($this->pdo);
            $token = $this->token->validatedToken($request['token']);

            // Retrieve data ONLY if token  
            if($token) {
                
                // domain, app always present
                if(!isset($request['per'])){$request['per']=20;}
                if(!isset($request['page'])){$request['page']=1;}
                if(!isset($request['limit'])){$request['limit']=100;}
                //
                $conditions = "";
                $domain = $request['domain'];
                $prefix = prefixed($domain);

                //
                $columns = "

                user_ID,		
                user_attributes,		
                user_alias,		
                user_password,		
                user_lastlogin,		
                user_status,		
                user_validation,		
                user_salt,		
                user_welcome	

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

                    $conditions.= " WHERE";
                    $conditions.= " " . $prefix . "_id = :id ";
                    $conditions.= " AND active = 1 ";
                    $conditions.= " ORDER BY time_finished DESC ";
                    
                    $subset = " LIMIT 1";

                    $sql = "SELECT ";
                    $sql.= $columns;
                    $sql.= " FROM " . $table;
                    $sql.= $conditions;
                    $sql.= $subset;
                    
                    //echo json_encode($request['id']);
                    //echo '<br/>';
                    //echo $sql; exit;

                    //
                    $statement = $this->pdo->prepare($sql);

                    // bind value to the :id parameter
                    $statement->bindValue(':id', $request['id']);

                    //echo $sql; exit;

                } else {

                    $conditions = "";
                    $refinements = "";
                    if(isset($request['id'])){$refinements.="user_id"." ILIKE "."'%".$request['id']."%' AND ";}		
                    if(isset($request['attributes'])){$refinements.="user_attributes"." ILIKE "."'%".$request['attributes']."%' AND ";}		
                    if(isset($request['alias'])){$refinements.="user_alias"." ILIKE "."'%".$request['alias']."%' AND ";}		
                    if(isset($request['password'])){$refinements.="user_password"." ILIKE "."'%".$request['password']."%' AND ";}		
                    if(isset($request['lastlogin'])){$refinements.="user_lastlogin"." ILIKE "."'%".$request['lastlogin']."%' AND ";}		
                    if(isset($request['status'])){$refinements.="user_status"." ILIKE "."'%".$request['status']."%' AND ";}		
                    if(isset($request['validation'])){$refinements.="user_validation"." ILIKE "."'%".$request['validation']."%' AND ";}		
                    if(isset($request['salt'])){$refinements.="user_salt"." ILIKE "."'%".$request['salt']."%' AND ";}		
                    if(isset($request['welcome'])){$refinements.="user_welcome"." ILIKE "."'%".$request['welcome']."%' AND ";}                    
                    //echo $conditions . 'conditions1<br/>';
                    //echo $refinements . 'refinements1<br/>';
                    
                    $conditions.= " WHERE ";
                    $conditions.= $refinements;
                    $conditions.= " active = 1 ";
                    $conditions.= " ORDER BY time_finished DESC ";
                    $subset = " OFFSET {$start}" . " LIMIT {$request['per']}";
                    $sql = "SELECT ";
                    $sql.= $columns;
                    $sql.= "FROM " . $table;
                    $sql.= $conditions;
                    $sql.= $subset;

                    //echo $conditions . 'conditions2<br/>';
                    //echo $refinements . 'refinements2<br/>';

                    //echo $sql; exit;
                    
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

                            'id' => $row['user_id'],
                            'attributes' => json_encode($row['user_attributes']),
                            'alias' => $row['user_alias'],
                            'password' => $row['user_password'],
                            'lastlogin' => $row['user_lastlogin'],
                            'status' => $row['user_status'],
                            'validation' => $row['user_validation'],
                            'salt' => $row['user_salt'],
                            'welcome' => json_encode($row['user_welcome'])

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
        public function updateUser($request) {

            //
            $domain = $request['domain'];
            $table = prefixed($domain);
            $id = $request['id'];

            //
            $set = "";
            if(isset($request['id'])){$set.= " user_id = :user_id ";}		
            if(isset($request['attributes'])){$set.= " user_attributes = :user_attributes ";}		
            if(isset($request['alias'])){$set.= " user_alias = :user_alias ";}		
            if(isset($request['password'])){$set.= " user_password = :user_password ";}		
            if(isset($request['lastlogin'])){$set.= " user_lastlogin = :user_lastlogin ";}		
            if(isset($request['status'])){$set.= " user_status = :user_status ";}		
            if(isset($request['validation'])){$set.= " user_validation = :user_validation ";}		
            if(isset($request['salt'])){$set.= " user_salt = :user_salt ";}		
            if(isset($request['welcome'])){$set.= " user_welcome = :user_welcome ";}
            //
            $set = str_replace('  ',',',$set);

            // GET table name
            $condition = $table."_id = :id";
            $condition.= " RETURNING " . $table . "_id";

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
            if(isset($request['id'])){$statement->bindValue(':user_id', $request['id']);}
            if(isset($request['attributes'])){$statement->bindValue(':user_attributes', $request['attributes']);}
            if(isset($request['alias'])){$statement->bindValue(':user_alias', $request['alias']);}
            if(isset($request['password'])){$statement->bindValue(':user_password', $request['password']);}
            if(isset($request['lastlogin'])){$statement->bindValue(':user_lastlogin', $request['lastlogin']);}
            if(isset($request['status'])){$statement->bindValue(':user_status', $request['status']);}
            if(isset($request['validation'])){$statement->bindValue(':user_validation', $request['validation']);}
            if(isset($request['salt'])){$statement->bindValue(':user_salt', $request['salt']);}
            if(isset($request['welcome'])){$statement->bindValue(':user_welcome', $request['welcome']);}
            $statement->bindValue(':id', $id);

            // update data in the database
            $statement->execute();

            $data = $statement->fetchAll();
            
            $data = $data[0]['0'];

            // return generated id
            return $data;

            // return the number of row affected
            //return $statement->rowCount();

        }

        /**
         * Delete a row in the stocks table specified by id
         * @param int $id
         * @return the number row deleted
         */
        public function deleteUser($request) {

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