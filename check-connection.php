<?php
    include 'connect.php';
    $conn = OpenConnection();
    echo "Connected Successfully";
    CloseConnection($conn);
?>
