<?php

header('Content-Type: application/json');


// this protocol is in charge of updating the Bio of the user and throwing back the user related information


// STEP 1. Check passed inf to this PHP file
if (empty($_REQUEST['id'])) {
    $return['status'] = '400';
    $return['message'] = 'Missing required information';
    echo json_encode($return);
    return;
}

$id = htmlentities($_REQUEST['id']);
$bio = htmlentities($_REQUEST['bio']);

//echo $id,$bio;

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


// STEP 3. Update Bio
$result = $access->updateBio($id, $bio);

// updated successfully
if ($result) {
    
    // select user to throw back to the user updated inf
    $user = $access->selectUserID($id);

    // throw back updated user information    
    if ($user) {
        $return['status'] = '200';
        $return['message'] = 'Bio has been updated';
        $return['id'] = $user['id'];
        $return['email'] = $user['email'];
        $return['firstName'] = $user['firstName'];
        $return['lastName'] = $user['lastName'];
        $return['birthday'] = $user['birthday'];
        $return['gender'] = $user['gender'];
        $return['cover'] = $user['cover'];
        $return['ava'] = $user['ava'];
        $return['bio'] = $user['bio'];
    } else {
        $return['status'] = '400';
        $return['message'] = 'Could not complete the process';
    }
    
// error while updating
} else {
    $return['status'] = '400';
    $return['message'] = 'Unable to update bio';
}


echo json_encode($return);
$access->disconnect();
