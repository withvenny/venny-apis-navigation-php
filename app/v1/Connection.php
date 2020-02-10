<?php

    //
    $db = parse_url(getenv("DATABASE_URL"));
    $db["path"] = ltrim($db["path"], "/");

    //
    $pdo = new PDO("pgsql:" . sprintf(
        "host=%s;port=%s;user=%s;password=%s;dbname=%s",
        $db["host"],
        $db["port"],
        $db["user"],
        $db["pass"],
        ltrim($db["path"], "/")
    ));

    //
    print_r($db);

    //
    $conn = pg_connect(getenv("DATABASE_URL"));

    //
    print_r($conn);

?>

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