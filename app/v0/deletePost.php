<?php

header('Content-Type: application/json');

// Deleting the post and all post related information

// STEP 1. Verification of the data received to this file
if (empty($_REQUEST['id'])) {
    $return['status'] = '400';
    $return['message'] = 'Missing required information';
    echo json_encode($return);
    return;
}

// safe mode of accessing id and encoding it
$id = htmlentities($_REQUEST['id']);


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


// STEP 3. Delete post
$result = $access->deletePost($id);

// deleted successfully
if ($result) {
    
    $return['status'] = '200';
    $return['message'] = 'Post is successfully delete';
    $return['deleted'] = $result;
    
// could not delete
} else {
    
    $return['status'] = '400';
    $return['message'] = 'Could not delete the post';
    $return['deleted'] = $result;
    
}

// disconnect from the server
$access->disconnect();

// throw back json to the user
echo json_encode($return);