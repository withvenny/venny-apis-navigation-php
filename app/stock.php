<?php

    require '../vendor/autoload.php';
    
    use PostgreSQLTutorial\Connection as Connection;
    use PostgreSQLTutorial\StockDB as StockDB;
    
    try {
        // connect to the PostgreSQL database
        $pdo = Connection::get()->connect();
        // 
        $stockDB = new StockDB($pdo);
        // get all stocks data
        $stock = $stockDB->findByPK(1);
        
        var_dump($stock);
        
    } catch (\PDOException $e) {
        echo $e->getMessage();
    }

?>