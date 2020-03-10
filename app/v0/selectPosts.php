<?php

// This files sends request to the server for retrieving all the posts related to the certain user.

header('Content-Type: application/json');


// STEP 1. Receive passed variables / information
if (!isset($_REQUEST['id']) && !isset($_REQUEST['limit']) && !isset($_REQUEST['offset'])) {
    $return['status'] = '400';
    $return['message'] = 'Missing required information';
    echo json_encode($return);
    return;
}

// encode received variables / information
$id = htmlentities($_REQUEST['id']);
$limit = htmlentities($_REQUEST['limit']);
$offset = htmlentities($_REQUEST['offset']);


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

//print_r($_REQUEST);exit;

// STEP 3. Select posts from the server
// If action is set already and is equal to FEED, then exec-te the function to load the feed, or load the normal posts of the user
if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'feed') {
    
    $posts = $access->selectPostsForFeed($id, $offset, $limit);
    
} else {
    
    $posts = $access->selectPosts($id, $offset, $limit);
    
}
    

// found posts / could not find
if ($posts) {
    $return['posts'] = $posts;
} else {
    $return['message'] = 'Coud not find posts';
}


// STEP 4. Disconnect
echo json_encode($return);
$access->disconnect();
