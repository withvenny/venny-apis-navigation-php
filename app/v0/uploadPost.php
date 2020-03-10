<?php

header('Content-Type: application/json');

// This file is reponsible for uploading information into server.


// STEP 1. Receive passed information. If some of the values are empty -> return and do not executed the code further.
if (empty($_REQUEST['user_id']) || empty($_REQUEST['text'])) {
    $return['status'] = '400';
    $return['message'] = 'Missing required information';
    echo json_encode($return);
    return;   
}

// safe method of casting received values
$user_id = htmlentities($_REQUEST['user_id']);
$text = htmlentities($_REQUEST['text']);
$picture = '';

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


// STEP 3. Check, is the image selected / passed or not and check the size of the image to be uploaded (must be +1 kb)
if (isset($_FILES['file']) && $_FILES['file']['size'] > 1) {
    
    // generating absolute path to the folder for every user with his unique id
    $folder = '/Applications/XAMPP/xamppfiles/htdocs/fb/posts/' . $user_id; // '/Applications/XAMPP/xamppfiles/htdocs/fb/posts/22'
    
    // creating fodler if it doesn't exist
    if (!file_exists($folder)) {
        mkdir($folder, 0777, true);
    } else {
        $return['folder_message'] = 'Could not create a directory';
    }
    
    // path to the file. Full path of the file
    $path = $folder . '/' . basename($_FILES['file']['name']); // '/Applications/XAMPP/xamppfiles/htdocs/fb/posts/22/picture1.jpg'
    
    // if file is uploaded successfully, then -> ... else/or ... ->
    if (move_uploaded_file($_FILES['file']['tmp_name'], $path)) {
        
        // creating URL link to the image uploaded
        $picture = 'http://localhost/fb/posts/' . $user_id . '/' . $_FILES['file']['name']; // http://localhost/fb/posts/22/picture1.jpg
        $return['picture'] = $picture;
        
    } else {
        $return['file_message'] = 'Could not upload the picture';
    }
    
}


// STEP 4. Insert details into database
$result = $access->insertPost($user_id, $text, $picture);

if ($result) {
    
    $return['status'] = '200';
    $return['message'] = 'Post is upladed successfully';
    
} else {
    
    $return['status'] = '400';
    $return['message'] = 'Could not upload post';
    
}


// disconeect and throw back JSON to the user
$access->disconnect();
echo json_encode($return);
