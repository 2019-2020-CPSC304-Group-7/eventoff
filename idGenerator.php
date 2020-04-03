<?php
    function randomTicketID($connection) {
        $query = "select ticket_id from ticket";
        $result = $connection->query($query);
        $ids = $result->fetch_assoc();
        $randomID = 0;
        do {
            $randomID = rand(100000, 999999);
        } while (in_array($randomID, $ids));
        return $randomID;
    }

    function randomEventID($connection) {
        $connection = openConnection();
        $query = "select event_id from `event`";
        $result = $connection->query($query);
        $ids = $result->fetch_assoc();
        $randomID = 0;
        do {
            $randomID = rand(1000, 9999);
        } while (in_array($randomID, $ids));
        return $randomID;
    }

    function randomScheduleID($connection) {
        $connection = openConnection($connection);
        $query = "select schedule_id from userschedule";
        $result = $connection->query($query);
        $ids = $result->fetch_assoc();
        $randomID = 0;
        do {
            $randomID = rand(100000, 999999);
        } while (in_array($randomID, $ids));
        return $randomID;
    }
?>