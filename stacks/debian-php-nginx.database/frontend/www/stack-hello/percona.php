<?php

header("Content-type: text/plain");

try {
    echo "Verifying Percona connection... ";
    $dbh = new PDO('mysql:host=percona', 'root', getenv('PERCONA_ENV_MYSQL_ROOT_PASSWORD'));
    echo "OK!";
} catch (PDOException $e) {
    echo "Failed";
}
