<?php
 
    require '../vendor/autoload.php';
    
    use PostgreSQLTutorial\Connection as Connection;
    use PostgreSQLTutorial\BlobDB as BlobDB;

    $pdo = Connection::get()->connect();
    var_dump($pdo);
    echo 'NEXT'; 

    $blobDB = new BlobDB($pdo);

    var_dump($blobDB);
    echo 'NEXT'; 
    
    // get document id from the query string
    $id = filter_input(INPUT_GET, 'id', FILTER_SANITIZE_NUMBER_INT);

    var_dump($id);
    echo 'NEXT'; 
    
    $file = $blobDB->read($id);

    var_dump($file);
    echo 'NEXT'; 

?>