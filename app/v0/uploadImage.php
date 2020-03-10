<?php

header('Content-Type: application/json');

// Uploading Files (cover / ava) to the server and updating the path in database


// STEP 1. Receive passed data to current PHP file
if (empty($_REQUEST['id']) || empty($_REQUEST['type'])) {
    
    $return['status'] = '400';
    $return['message'] = 'Missing required information';
    echo json_encode($return);
    return;
    
}

// using protection method to cast received data
$id = htmlentities($_REQUEST['id']);
$type = htmlentities($_REQUEST['type']);
$return = array();


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


// STEP 3. Upload file
if (isset($_FILES['file']) && $_FILES['file']['size'] > 1) {
    
    // Applications > XAMPP > xamppfiles > htdocs > fb > cover/ava > 777
    $folder = '/Applications/XAMPP/xamppfiles/htdocs/fb/' . $type . '/' . $id;
    
    // server is automatically creating dedicated folder for every user to store his files
    if (!file_exists($folder)) {
        mkdir($folder, 0777, true);
    } else {
        $return['folder_message'] = 'Could not create a folder';
    }
    
    // Applications > XAMPP > xamppfiles > htdocs > fb > cover/ava > 777 > ava.jpg
    $filePath = $folder . '/' . basename($_FILES['file']['name']);
    
    if (move_uploaded_file($_FILES['file']['tmp_name'], $filePath)) {
        
        // http://localhost/fb/cover(ava)/777/ava.jpg
        $fileURL = 'http://localhost/fb/' . $type . '/' . $id . '/' . $_FILES['file']['name'];
        
        // update the URL path in the server
        $access->updateImageURL($type, $fileURL, $id);
                        
    } else {
        $return['status'] = '400';
        $return['message'] = 'Could not upload the file';
    }
    

// Delete File    
} else {
    
    $fileURL = '';
    
    $files = glob('/Applications/XAMPP/xamppfiles/htdocs/fb/' . $type . '/' . $id . '/*'); // /Application/XAMPP/xamppfiles/htdocs/fb/cover/777/*
    
    foreach($files as $file) { // iterate files
        
        if (is_file($file))
        unlink ($file); // delete file
        
        // update the URL path in the server
        $access->updateImageURL($type, $fileURL, $id);
    }
    
}


// throwing back UPDATED infromation related to the user (e.g. cover, ava)
$user = $access->selectUserID($id);        

if ($user) {
    // return JSON to the user
    $return['status'] = '200';
    $return['message'] = 'File ' . $type . ' has been uploaded successfully';
    $return['' . $type . ''] = $fileURL;        
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

$access->disconnect();
echo json_encode($return);