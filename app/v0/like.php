<?php

header('Content-Type: application/json');

// This file is responsible for liking and unliking (inserting Like into DB and deleting Like from the DN)


// STEP 1. Receive values passed to current file
if (empty($_REQUEST['post_id']) || empty($_REQUEST['user_id'])) {
    $return['status'] = '400';
    $return['message'] = 'Missing required information';
    echo json_encode($return);
    return;
}

// secure method of receiving values passed to current file
$post_id = htmlentities($_REQUEST['post_id']);
$user_id = htmlentities($_REQUEST['user_id']);


// STEP 2. Build Connection
// Secure way to store Connection Infromation
$file = parse_ini_file("../../app.ini");   // accessing the file with connection infromation

// retrieve data from file
$host = trim($file["dbhost"]);
$user = trim($file["dbuser"]);
$pass = trim($file["dbpass"]);
$name = trim($file["dbname"]);

// include MySQLDAO.php for connection and interacting with db
require("secure/access.php");

// running MySQLDAO Class with constructed variables
$access = new access($host, $user, $pass, $name);
$access->connect();   // launch opend connection function



// STEP 3. Insert or Delete Like
// Insert
if ($_REQUEST['action'] == "insert") {
    
    // run protocol from Access.php that inserts Like
    $result = $access->insertLike($post_id, $user_id);
    
    // Liked successfully
    if ($result) {
        $return['status'] = '200';
        $return['message'] = 'Like has been registered successfully';
        
    // Could not insert Like
    } else {
        $return['status'] = '400';
        $return['message'] = 'Could not register Like';
    }
    
// Delete
} else {
    
    // run protocol from Access.php that deletes Like
    $result = $access->deleteLike($post_id, $user_id);
    
    // Deleted successfully
    if ($result) {
        $return['status'] = '200';
        $return['message'] = 'Like has been removed successfully';
    
    // Could not delete Like
    } else {
        $return['status'] = '400';
        $return['message'] = 'Could not remove Like';
    }
     
}


// STEP 4. Close connection
echo json_encode($return);
$access->disconnect();