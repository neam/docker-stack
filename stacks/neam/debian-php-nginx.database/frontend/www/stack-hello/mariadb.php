<?php

header("Content-type: text/plain");

try {
    echo "Verifying MariaDB connection... ";
    $dbh = new PDO('mysql:host=mariadb', 'root', getenv('MARIADB_ENV_MYSQL_ROOT_PASSWORD'));
    echo "OK!";
} catch (PDOException $e) {
    echo "Failed";
}
