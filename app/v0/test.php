<?php


header('Content-Type: application/json');


/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


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

$id = htmlentities($_REQUEST['id']);
    
$users = $access->selectRecommendedFriends($id);


echo json_encode($users);
$access->disconnect();
