<?php
 
    require '../vendor/autoload.php';
    
    use PostgreSQLTutorial\Connection as Connection;
    //use PostgreSQLTutorial\PostgreSQLCreateTable as PostgreSQLCreateTable;
    //use PostgreSQLTutorial\PostgreSQLPHPInsert as PostgreSQLPHPInsert;
    //use PostgreSQLTutorial\PostgreSQLPHPUpdate as PostgreSQLPHPUpdate;
    use PostgreSQLTutorial\StockDB as StockDB;
    
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

?>

<!DOCTYPE html>
<html>
    <head>
        <title>PostgreSQL PHP Querying Data Demo</title>
        <link rel="stylesheet" href="https://cdn.rawgit.com/twbs/bootstrap/v4-dev/dist/css/bootstrap.css">
    </head>
    <body>
        <div class="container">
            <h1>Stock List</h1>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Symbol</th>
                        <th>Company</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($stocks as $stock) : ?>
                        <tr>
                            <td><?php echo htmlspecialchars($stock['id']) ?></td>
                            <td><?php echo htmlspecialchars($stock['symbol']); ?></td>
                            <td><?php echo htmlspecialchars($stock['company']); ?></td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </body>
</html>