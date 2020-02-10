<?php
 
    require '../vendor/autoload.php';
    
    use PostgreSQLTutorial\Connection as Connection;
    use PostgreSQLTutorial\PostgreSQLCreateTable as PostgreSQLCreateTable;
    use PostgreSQLTutorial\PostgreSQLPHPInsert as PostgreSQLPHPInsert;
    
    // Connection
    try {
        Connection::get()->connect();
        echo 'A connection to the PostgreSQL database sever has been established successfully.';
    } catch (\PDOException $e) {
        echo $e->getMessage();
    }

    // PostgreSQLCreateTable
    try {
    
        // connect to the PostgreSQL database
        $pdo = Connection::get()->connect();
        
        // 
        $tableCreator = new PostgreSQLCreateTable($pdo);
        
        // create tables and query the table from the
        // database
        $tables = $tableCreator->createTables()
                                ->getTables();
        
        foreach ($tables as $table){
            echo $table . '<br>';
        }
        
    } catch (\PDOException $e) {
        echo $e->getMessage();
    }

    // PostgreSQLPHPInsert
    try {
        // connect to the PostgreSQL database
        $pdo = Connection::get()->connect();
        // 
        $insertDemo = new PostgreSQLPHPInsert($pdo);
     
        // insert a stock into the stocks table
        $id = $insertDemo->insertStock('MSFT', 'Microsoft Corporation');
        echo 'The stock has been inserted with the id ' . $id . '<br>';
     
        // insert a list of stocks into the stocks table
        $list = $insertDemo->insertStockList([
            ['symbol' => 'GOOG', 'company' => 'Google Inc.'],
            ['symbol' => 'YHOO', 'company' => 'Yahoo! Inc.'],
            ['symbol' => 'FB', 'company' => 'Facebook, Inc.'],
        ]);
     
        foreach ($list as $id) {
            echo 'The stock has been inserted with the id ' . $id . '<br>';
        }
    } catch (\PDOException $e) {
        echo $e->getMessage();
    }

?>
