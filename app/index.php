<?php
 
    require '../vendor/autoload.php';
    
    use PostgreSQLTutorial\Connection as Connection;
    //use PostgreSQLTutorial\PostgreSQLCreateTable as PostgreSQLCreateTable;
    //use PostgreSQLTutorial\PostgreSQLPHPInsert as PostgreSQLPHPInsert;
    //use PostgreSQLTutorial\PostgreSQLPHPUpdate as PostgreSQLPHPUpdate;
    use PostgreSQLTutorial\StockDB as StockDB;
    //use PostgreSQLTutorial\AccountDB as AccountDB;
    //use PostgreSQLTutorial\StoreProc as StoreProc;
    //use PostgreSQLTutorial\BlobDB as BlobDB;

    // Connection
    /*
    try {
        Connection::get()->connect();
        echo 'A connection to the PostgreSQL database sever has been established successfully.';
    } catch (\PDOException $e) {
        echo $e->getMessage();
    }
    */

    // PostgreSQLCreateTable
    /*
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
    */

    // PostgreSQLPHPInsert
    /*
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
    */

    //
    /*
    try {
        // connect to the PostgreSQL database
        $pdo = Connection::get()->connect();
    
        // 
        $updateDemo = new PostgreSQLPHPUpdate($pdo);
    
        // insert a stock into the stocks table
        $affectedRows = $updateDemo->updateStock(3, 'GOOGL', 'Alphabet Inc.');
    
        echo 'Number of row affected ' . $affectedRows;
    } catch (\PDOException $e) {
        echo $e->getMessage();
    }*/

    //
    /*
    try {
        // connect to the PostgreSQL database
        $pdo = Connection::get()->connect();
        // 
        $stockDB = new StockDB($pdo);
        // get all stocks data
        $stocks = $stockDB->all();
    } catch (\PDOException $e) {
        echo $e->getMessage();
    }
    */

    //
    /*
    try {
        // connect to the PostgreSQL database
        $pdo = Connection::get()->connect();
     
        $accountDB = new AccountDB($pdo);
     
        // add accounts
        $accountDB->addAccount('John', 'Doe', 1, date('Y-m-d'));
        $accountDB->addAccount('Linda', 'Williams', 2, date('Y-m-d'));
        $accountDB->addAccount('Maria', 'Miller', 3, date('Y-m-d'));
     
     
        echo 'The new accounts have been added.' . '<br>';
        // 
        $accountDB->addAccount('Susan', 'Wilson', 99, date('Y-m-d'));
    } catch (\PDOException $e) {
        echo $e->getMessage();
    }
    */

    //
    /*
    try {
        // connect to the PostgreSQL database
        $pdo = Connection::get()->connect();
        // 
        $storeProc = new StoreProc($pdo);
     
        $result = $storeProc->add(20, 30);
        echo $result;
        
    } catch (\PDOException $e) {
        echo $e->getMessage();
    }
    */

    //
    /*
    try {
        // connect to the PostgreSQL database
        $pdo = Connection::get()->connect();
        // 
        $storeProc = new StoreProc($pdo);
       
        $accounts = $storeProc->getAccounts();
        
    } catch (\PDOException $e) {
        echo $e->getMessage();
    }
    */

    /*
    try {
        // connect to the PostgreSQL database
        $pdo = Connection::get()->connect();
        // 
        $blobDB = new BlobDB($pdo);
        $fileId = $blobDB->insert(5, 'logo', 'image/png', 'assets/images/google.png');
     
        echo 'A file has been inserted with id ' . $fileId;
    } catch (\PDOException $e) {
        echo $e->getMessage();
    }
    */

    try {
        // connect to the PostgreSQL database
        $pdo = Connection::get()->connect();
        // 
        $stockDB = new StockDB($pdo);
        // delete a stock with a specified id
        $deletedRows = $stockDB->delete(4);
        echo 'The number of row(s) deleted: ' . $deletedRows . '<br>';
        
    } catch (\PDOException $e) {
        echo $e->getMessage();
    }

?>
