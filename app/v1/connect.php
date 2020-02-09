<?php

    //
    $db = parse_url(getenv("DATABASE_URL"));
    $db["path"] = ltrim($db["path"], "/");

    //
    print_r($db);

    //
    $conn = pg_connect(getenv("DATABASE_URL"));

?>