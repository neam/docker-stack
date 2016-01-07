<?php

header("Content-type: text/plain");

try {
    echo "Verifying MySQL connection... ";
    $dbh = new PDO('mysql:host=mysql', 'root', getenv('MYSQL_ENV_MYSQL_ROOT_PASSWORD'));
    echo "OK!";
} catch (PDOException $e) {
    echo "Failed";
}
