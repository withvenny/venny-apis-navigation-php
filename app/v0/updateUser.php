<?php

header('Content-Type: application/json');

 
//This fils is responsible for updating user related infromation in the server

// STEP 1. Receiving passed infromation to current file
if (empty($_REQUEST['id']) || empty($_REQUEST['email']) || empty($_REQUEST['firstName']) || empty($_REQUEST['lastName']) 
        || empty($_REQUEST['birthday']) || !isset($_REQUEST['gender']) || !isset($_REQUEST['allow_friends']) || !isset($_REQUEST['allow_follow']) ) {
    
    $return['status'] = '400';
    $return['message'] = 'Missing required information';
    echo json_encode($return);
    return;
    
}

// secure infromation and store in vars
$id = htmlentities($_REQUEST['id']);
$email = htmlentities($_REQUEST['email']);
$firstName = htmlentities($_REQUEST['firstName']);
$lastName = htmlentities($_REQUEST['lastName']);
$birthday = htmlentities($_REQUEST['birthday']);
$gender = htmlentities($_REQUEST['gender']);
$allow_friends = htmlentities($_REQUEST['allow_friends']);
$allow_follow = htmlentities($_REQUEST['allow_follow']);

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


// STEP 3. Update user information
$result = $access->updateUser($email, $firstName, $lastName, $birthday, $gender, $allow_friends, $allow_follow, $id);

if ($result) {
    
    // updated successfully
    $return['status'] = '200';
    $return['message'] = 'User is updated successfully';
    
    
    // STEP 4. Update passowrd
    if ($_REQUEST['newPassword'] == 'true') {
        
        // receiving new password. generating new salt. generating new Super Securerd password
        $password = htmlentities($_REQUEST['password']);
        $salt = openssl_random_pseudo_bytes(20);
        $dbpassword = sha1($password . $salt);
        
        // updating password in database
        $passwordChanged = $access->updatePassword($id, $dbpassword, $salt);
        
        // logic of scenarious
        if ($passwordChanged) {
            $return['password'] = 'Password is changed successfully';
        } else {
            $return['password'] = 'Password could not be changed';
        }
        
    }
    
    // STEP 5. Return back user related information
    $user = $access->selectUserID($id);
    
    // logic of scenarious
    if ($user) {
        
        $return['id'] = $user['id'];
        $return['email'] = $user['email'];
        $return['firstName'] = $user['firstName'];
        $return['lastName'] = $user['lastName'];
        $return['birthday'] = $user['birthday'];
        $return['gender'] = $user['gender'];
        $return['cover'] = $user['cover'];
        $return['ava'] = $user['ava'];
        $return['bio'] = $user['bio'];
        $return['allow_friends'] = $user['allow_friends'];
        $return['allow_follow'] = $user['allow_follow'];
        
    } else {
        $return['status'] = '400';
        $return['message'] = 'Could not complete the process';
    }
    
    
} else {
    
    // can not update
    $return['status'] = '400';
    $return['message'] = 'Could not update user';
    
}


// STEP 7. Shut down
$access->disconnect();
echo json_encode($return);
