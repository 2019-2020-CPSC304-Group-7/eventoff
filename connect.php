<?php
function openConnection()
{
    $dbhost = "localhost";
    $dbuser = "root";
    $dbpass = "root";
    $db = "zagi";
    $connection = new mysqli($dbhost, $dbuser, $dbpass, $db) or die("Connect failed: %s\n" . $connection->error);
    return $connection;
}

function closeConnection($connection)
{
    $connection->close();
}

?>