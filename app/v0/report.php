<?php

header('Content-Type: application/json');

// Reponsible for inserting reports and complaints into database


// STEP 1. check if the requried information passed to current PHP file or not
if (!isset($_REQUEST['byUser_id']) || !isset($_REQUEST['user_id']) || !isset($_REQUEST['post_id']) || !isset($_REQUEST['reason'])) {    
    $return['status'] = '200';
    $return['message'] = 'Missing required information';
    echo json_encode($return);
    return;
}

// safe mode of casting value
$post_id = htmlentities($_REQUEST['post_id']);
$user_id = htmlentities($_REQUEST['user_id']);
$reason = htmlentities($_REQUEST['reason']);
$byUser_id = htmlentities($_REQUEST['byUser_id']);



// STEP 2. Build Connection
// Secure way to store Connection Infromation
$file = parse_ini_file("../../app.ini");   // ac;/cessing the file with connection infromation

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



// STEP 3. Insert Complaint
$result = $access->insertReport($post_id, $user_id, $reason, $byUser_id);

// check the status of exec-tion
// inserted successfully
if ($result) {
    $return['status'] = '200';
    $return['message'] = 'Reported successfully';

    
// could not insert
} else {
    $return['status'] = '400';
    $return['message'] = 'Error while sending your feedback';
}


// STEP 4. Disconnect and provide user with the JSON information
$access->disconnect();
echo json_encode($return);