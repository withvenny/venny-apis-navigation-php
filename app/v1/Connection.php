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
            print_r($stmt); exit;
            
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

?>