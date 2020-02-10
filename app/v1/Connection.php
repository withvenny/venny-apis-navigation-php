<?php

    namespace PostgreSQLTutorial;

    /**
     * Represent the Connection
     */
    class Connection {
    
        /**
         * Connection
         * @var type 
         */
        private static $conn;
    
        /**
         * Connect to the database and return an instance of \PDO object
         * @return \PDO
         * @throws \Exception
         */
        public function connect() {

            // read parameters in the ini configuration file
            //$params = parse_ini_file('database.ini');
            $db = parse_url(getenv("DATABASE_URL"));

            //if ($params === false) {throw new \Exception("Error reading database configuration file");}
            if ($db === false) {throw new \Exception("Error reading database configuration file");}
            // connect to the postgresql database
            $conStr = sprintf("pgsql:host=%s;port=%d;dbname=%s;user=%s;password=%s", 
                    $db['host'], 
                    $db['port'], 
                    ltrim($db["path"], "/"), 
                    $db['user'], 
                    $db['pass']);
    
            $pdo = new \PDO($conStr);
            $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
    
            return $pdo;
        }
    
        /**
         * return an instance of the Connection object
         * @return type
         */
        public static function get() {
            if (null === static::$conn) {
                static::$conn = new static();
            }
    
            return static::$conn;
        }
    
        protected function __construct() {
            
        }
    
        private function __clone() {
            
        }
    
        private function __wakeup() {
            
        }
    
    }

    /**
     * Represent the table creation
     */
    class PostgreSQLCreateTable {
    
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
         * create tables 
         */
        public function createTables() {
            $sqlList = ['CREATE TABLE IF NOT EXISTS stocks (
                            id serial PRIMARY KEY,
                            symbol character varying(10) NOT NULL UNIQUE,
                            company character varying(255) NOT NULL UNIQUE 
                        );',
                'CREATE TABLE IF NOT EXISTS stock_valuations (
                            stock_id INTEGER NOT NULL,
                            value_on date NOT NULL,
                            price numeric(8,2) NOT NULL DEFAULT 0,
                            PRIMARY KEY (stock_id, value_on),
                            FOREIGN KEY (stock_id) REFERENCES stocks(id)
                        );'];
    
            // execute each sql statement to create new tables
            foreach ($sqlList as $sql) {
                $this->pdo->exec($sql);
            }
            
            return $this;
        }
    
        /**
         * return tables in the database
         */
        public function getTables() {
            $stmt = $this->pdo->query("SELECT table_name 
                                    FROM information_schema.tables 
                                    WHERE table_schema= 'public' 
                                            AND table_type='BASE TABLE'
                                    ORDER BY table_name");
            $tableList = [];
            while ($row = $stmt->fetch(\PDO::FETCH_ASSOC)) {
                $tableList[] = $row['table_name'];
            }
    
            return $tableList;
        }
    }

    /**
     * Represent the table data insertion
     */
    class PostgreSQLPHPInsert {

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

        public function insertStock($symbol, $company) {

            // prepare statement for insert
            $sql = 'INSERT INTO stocks(symbol,company) VALUES(:symbol,:company)';
            //echo $sql; exit;
            $stmt = $this->pdo->prepare($sql);
            //print_r($stmt); exit;
            
            // pass values to the statement
            $stmt->bindValue(':symbol', $symbol);
            $stmt->bindValue(':company', $company);
            
            // execute the insert statement
            $stmt->execute();
            
            // return generated id
            return $this->pdo->lastInsertId('stocks_id_seq');
        }

        /**
         * Insert multiple stocks into the stocks table
         * @param array $stocks
         * @return a list of inserted ID
         */

        public function insertStockList($stocks) {
            $sql = 'INSERT INTO stocks(symbol,company) VALUES(:symbol,:company)';
            $stmt = $this->pdo->prepare($sql);

            $idList = [];
            foreach ($stocks as $stock) {
                $stmt->bindValue(':symbol', $stock['symbol']);
                $stmt->bindValue(':company', $stock['company']);
                $stmt->execute();
                $idList[] = $this->pdo->lastInsertId('stocks_id_seq');
            }
            return $idList;
        }

    }

    /**
     * Represent the table data insertion
     */
    class PostgreSQLPHPUpdate {

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

        public function updateStock($id, $symbol, $company) {

            /**
             * Update stock based on the specified id
             * @param int $id
             * @param string $symbol
             * @param string $company
             * @return int
             */
 
            // sql statement to update a row in the stock table
            $sql = 'UPDATE stocks '
                    . 'SET company = :company, '
                    . 'symbol = :symbol '
                    . 'WHERE id = :id';
     
            $stmt = $this->pdo->prepare($sql);
     
            // bind values to the statement
            $stmt->bindValue(':symbol', $symbol);
            $stmt->bindValue(':company', $company);
            $stmt->bindValue(':id', $id);
            // update data in the database
            $stmt->execute();
     
            // return the number of row affected
            return $stmt->rowCount();
        }

    }

    /**
     * Represent the table data insertion
     */
    class StockDB {

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
         * Return all rows in the stocks table
         * @return array
         */
        public function all() {
            $stmt = $this->pdo->query('SELECT id, symbol, company '
                    . 'FROM stocks '
                    . 'ORDER BY symbol');
            $stocks = [];
            while ($row = $stmt->fetch(\PDO::FETCH_ASSOC)) {
                $stocks[] = [
                    'id' => $row['id'],
                    'symbol' => $row['symbol'],
                    'company' => $row['company']
                ];
            }
            return $stocks;
        }

        /**
         * Find stock by id
         * @param int $id
         * @return a stock object
         */
        public function findByPK($id) {
            // prepare SELECT statement
            $stmt = $this->pdo->prepare('SELECT id, symbol, company
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

    class AccountDB {

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
         * Add a new account
         * @param string $firstName
         * @param string $lastName
         * @param int $planId
         * @param date $effectiveDate
         */
        public function addAccount($firstName, $lastName, $planId, $effectiveDate) {
            try {
                // start the transaction
                $this->pdo->beginTransaction();
    
                // insert an account and get the ID back
                $accountId = $this->insertAccount($firstName, $lastName);
    
                // add plan for the account
                $this->insertPlan($accountId, $planId, $effectiveDate);
    
                // commit the changes
                $this->pdo->commit();
            } catch (\PDOException $e) {
                // rollback the changes
                $this->pdo->rollBack();
                throw $e;
            }
        }

        /**
         * 
         * @param string $firstName
         * @param string $lastName
         * @return int
         */
        private function insertAccount($firstName, $lastName) {
            $stmt = $this->pdo->prepare(
                    'INSERT INTO accounts(first_name,last_name) '
                    . 'VALUES(:first_name,:last_name)');
    
            $stmt->execute([
                ':first_name' => $firstName,
                ':last_name' => $lastName
            ]);
    
            return $this->pdo->lastInsertId('accounts_id_seq');
        }
        
        /**
         * insert a new plan for an account
         * @param int $accountId
         * @param int $planId
         * @param int $effectiveDate
         * @return bool
         */
        private function insertPlan($accountId, $planId, $effectiveDate) {
            $stmt = $this->pdo->prepare(
                    'INSERT INTO account_plans(account_id,plan_id,effective_date) '
                    . 'VALUES(:account_id,:plan_id,:effective_date)');
    
            return $stmt->execute([
                        ':account_id' => $accountId,
                        ':plan_id' => $planId,
                        ':effective_date' => $effectiveDate,
            ]);
        }
    }

    class StoreProc {

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
         * Call a simple stored procedure
         * @param int $a
         * @param int $b
         * @return int
         */
        public function add($a, $b) {
            $stmt = $this->pdo->prepare('SELECT * FROM add(:a,:b)');
            $stmt->setFetchMode(\PDO::FETCH_ASSOC);
            $stmt->execute([
                ':a' => $a,
                ':b' => $b
            ]);
            return $stmt->fetchColumn(0);
        }

        /**
         * Call a stored procedure that returns a result set
         * @return array
         */
        function getAccounts() {
            $stmt = $this->pdo->query('SELECT * FROM get_accounts()');
            $accounts = [];
            while ($row = $stmt->fetch()) {
                $accounts[] = [
                    'id' => $row['id'],
                    'first_name' => $row['first_name'],
                    'last_name' => $row['last_name'],
                    'plan' => $row['plan'],
                    'effective_date' => $row['effective_date']
                ];
            }
            return $accounts;
        }
    }

    class BlobDB {

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
         * Insert a file into the company_files table
         * @param int $stockId
         * @param string $fileName
         * @param string $mimeType
         * @param string $pathToFile
         * @return int
         * @throws \Exception
         */
        public function insert($stockId, $fileName, $mimeType, $pathToFile) {
            if (!file_exists($pathToFile)) {
                throw new \Exception("File %s not found.");
            }
    
            $sql = "INSERT INTO company_files(stock_id,mime_type,file_name,file_data) "
                    . "VALUES(:stock_id,:mime_type,:file_name,:file_data)";
    
            try {
                $this->pdo->beginTransaction();
                
                // create large object
                $fileData = $this->pdo->pgsqlLOBCreate();
                $stream = $this->pdo->pgsqlLOBOpen($fileData, 'w');
                
                // read data from the file and copy the the stream
                $fh = fopen($pathToFile, 'rb');
                stream_copy_to_stream($fh, $stream);
                //
                $fh = null;
                $stream = null;
    
                $stmt = $this->pdo->prepare($sql);
    
                $stmt->execute([
                    ':stock_id' => $stockId,
                    ':mime_type' => $mimeType,
                    ':file_name' => $fileName,
                    ':file_data' => $fileData,
                ]);
    
                // commit the transaction
                $this->pdo->commit();
            } catch (\Exception $e) {
                $this->pdo->rollBack();
                throw $e;
            }
    
            return $this->pdo->lastInsertId('company_files_id_seq');
        }

        /**
         * Read BLOB from the database and output to the web browser
         * @param int $id
         */
        public function read($id) {

            var_dump($id);
            echo 'read()NEXT'; 
    
            $this->pdo->beginTransaction();
    
            $stmt = $this->pdo->prepare("SELECT id, file_data, mime_type "
                    . "FROM company_files "
                    . "WHERE id= :id");

            //var_dump($stmt); exit;
    
            // query blob from the database
            $stmt->execute([$id]);
    
            $stmt->bindColumn('file_data', $fileData, \PDO::PARAM_STR);
            $stmt->bindColumn('mime_type', $mimeType, \PDO::PARAM_STR);
            $stmt->fetch(\PDO::FETCH_BOUND);
            $stream = $this->pdo->pgsqlLOBOpen($fileData, 'r');
    
            // output the file
            header("Content-type: " . $mimeType);
            fpassthru($stream);
        }

    }

?>