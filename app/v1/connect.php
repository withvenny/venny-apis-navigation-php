<?php

    //
    header('Content-Type: application/json');

    //
    $db = parse_url(getenv("DATABASE_URL"));
    $db["path"] = ltrim($db["path"], "/");

    //
    $pdo = new PDO("pgsql:" . sprintf(
        "host=%s;port=%s;user=%s;password=%s;dbname=%s",
        $db["host"],
        $db["port"],
        $db["user"],
        $db["pass"],
        ltrim($db["path"], "/")
    ));

    //
    print_r($db);

    //
    $conn = pg_connect(getenv("DATABASE_URL"));

    //
    print_r($conn);

?>