<?php

header("Content-type: text/plain");

try {
    echo "Verifying MongoDB connection... ";
    $connection = new MongoClient("mongodb://mongodb:27017");
    echo "OK!";
} catch (PDOException $e) {
    echo "Failed";
}
