<?php
    include 'connect.php';
    session_start();
    $connection = openConnection();
    $name = $_GET["user"];
    $userID = $_GET["userID"];
?>

<html lang="eng">
    <head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <title>
        EventOFF
    </title>
    </head>
    <body>
        <div class="alert alert-success" role="alert">
            <?php
                echo '<h5>Welcome <b>' .$name. '</b></h5>';
            ?>
        </div>
        <!-- Forms for host queries -->

        <!-- Quick Actions -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                <b>Quick Actions</b>
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-row">
                        <div class="col-md-3 mb-3">
                            <input type="submit" name="events" class="btn btn-primary" value="See All Your Events">
                        </div>
                        <div class="col-md-3 mb-3">
                            <input type="submit" name="allPeople" class="btn btn-primary" value="Get Everyone Attending Your Event">
                        </div>
                    </div>
                </form>
            </div>
            <!-- PHP for All Events -->
            <?php 
                if(isset($_POST["events"])) {
                    $query = "SELECT e.name as n1, e.start_date, e.end_date, e.ranking, v.name as n2, COUNT(p.ticket_id) as attendance
                                FROM `event` e, bookedat b, venue2 v, isfor i, purchased p
                                WHERE e.host_id = $userID AND e.event_id = b.event_id
                                AND b.venue_id = v.venue_id AND e.event_id = i.event_id AND i.ticket_id = p.ticket_id
                                GROUP BY e.name
                                ORDER BY Attendance DESC";
                    $result = $connection->query($query);
                    if ($result->num_rows > 0) {
                        echo '<div class="card-body">
                                <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Event Name</th>
                                        <th scope="col">Start Date</th>
                                        <th scope="col">End Date</th>
                                        <th scope="col">Ranking</th>
                                        <th scope="col">Venue</th>
                                        <th scope="col">Tickets Sold</th>
                                    <tr>
                                </thead>
                                <tbody>';
                        while ($rows = $result->fetch_assoc()) {
                            echo '<tr>
                                    <td>' .$rows["n1"]. '</td>
                                    <td>' .$rows["start_date"]. '</td>
                                    <td>' .$rows["end_date"]. '</td>
                                    <td>' .$rows["ranking"]. '</td>
                                    <td>' .$rows["n2"]. '</td>
                                    <td>' .$rows["attendance"]. '</td>
                                    </tr>';
                        }
                        echo '</tbody>
                            </table>
                            </div>';
                    }
                    else {
                        echo '<div class="card-body">
                            <div class="alert alert-warning" role="alert">
                                No Results Found.
                            </div>
                            </div>';
                    }
                }
            ?>

            <!-- PHP for get all people -->
            <?php
                if (isset($_POST["allPeople"])) {
                    $query = "SELECT r3.name, r2.address, r1.email
                                FROM regularuser3 r3, regularuser2 r2, regularuser1 r1
                                WHERE r3.name = r2.name AND r2.name = r1.name 
                                AND NOT EXISTS 
                                    (SELECT e.event_id 
                                    FROM `event` e 
                                    WHERE e.host_id = $userID 
                                    AND NOT EXISTS 
                                        (SELECT p.user_id 
                                            FROM purchased p, isfor i 
                                            WHERE e.event_id = i.event_id AND p.ticket_id = i.ticket_id AND p.user_id = r3.user_id))";
                    $result = $connection->query($query);
                    if ($result->num_rows > 0) {
                        echo '<div class="card-body">
                                <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Name</th>
                                        <th scope="col">Address</th>
                                        <th scope="col">Email</th>
                                    <tr>
                                </thead>
                                <tbody>';
                        while ($rows = $result->fetch_assoc()) {
                            echo '<tr>
                                    <td>' .$rows["name"]. '</td>
                                    <td>' .$rows["address"]. '</td>
                                    <td>' .$rows["email"]. '</td>
                                    </tr>';
                        }
                        echo '</tbody>
                            </table>
                            </div>';
                    }
                    else {
                        echo '<div class="card-body">
                            <div class="alert alert-warning" role="alert">
                                No Results Found.
                            </div>
                            </div>';
                    }
                }
            ?>
        </div>

        <!-- Add tickets for an event -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Add a Ticket for one of Your Events
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-group">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon3">Event</span>
                            </div>
                            <?php
                                $query = "SELECT name 
                                            FROM `event` WHERE host_id = $userID";
                                $result = $connection->query($query);
                            ?>
                            <select name="eventList" class="form-control">
                            <?php 
                                while ($row = $result->fetch_assoc()) {
                            ?>
                            <option value="<?php echo $row['name'];?>">
                                <?php echo $row['name'];?>
                            </option>
                            <?php
                                }
                            ?>
                            </select>
                        </div>
                        <div class="form-row">
                            <div class="col-md-3">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="basic-addon3">$</span>
                                    </div>
                                    <input type="number" name="price" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon3">Vendor</span>
                            </div>
                            <?php
                                $query = "SELECT name 
                                            FROM ticketvendor2";
                                $result = $connection->query($query);
                            ?>
                            <select name="vendorList" class="form-control">
                            <?php 
                                while ($row = $result->fetch_assoc()) {
                            ?>
                            <option value="<?php echo $row['name'];?>">
                                <?php echo $row['name'];?>
                            </option>
                            <?php
                                }
                            ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="submit" name="addTicket" class="btn btn-primary" value="Add Ticket">
                    </div>
                </form>
            </div>
            <!-- PHP for SQL -->
            <?php
                include 'idGenerator.php';
                if (isset($_POST["addTicket"])) {
                    $price = $_POST["price"];
                    $event = $_POST["eventList"];
                    $vendor = $_POST["vendorList"];
                    $getVendorID = "SELECT vendor_id
                                    FROM ticketvendor2
                                    WHERE name = '$vendor'";
                    $getEventID = "SELECT e.event_id
                                FROM `event` e
                                WHERE e.name = '$event' AND e.host_id = $userID";
                    $vendorResult = $connection->query($getVendorID);
                    $vendorData = $vendorResult->fetch_assoc();
                    $vendorID = $vendorData["vendor_id"];
                    $eventResult = $connection->query($getEventID);
                    $eventData = $eventResult->fetch_assoc();
                    $eventID = $eventData["event_id"];
                    $ticketID = randomTicketID($connection);
                    $addToTickets = "INSERT INTO ticket(ticket_id, price) VALUES($ticketID, $price)";
                    $addToIsFor = "INSERT INTO isfor(ticket_id, event_id) VALUES($ticketID, $eventID)";
                    $addToSells = "INSERT INTO sells(vendor_id, ticket_id) VALUES($vendorID, $ticketID)";
                    if ($connection->query($addToTickets) === FALSE ||
                        $connection->query($addToIsFor) === FALSE ||
                        $connection->query($addToSells) === FALSE) {
                            echo '<div class="card-body">
                                    <div class="alert alert-warning" role="alert">
                                        Error in Adding Ticket. Please try again.
                                    </div>
                                    </div>';
                    }
                    else {
                        echo '<div class="card-body">
                                <div class="alert alert-success" role="alert">
                                    Ticket was added successfully.
                                </div>
                                </div>';
                    }
                }
            ?>
        </div>        

        <!-- Update Event -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Update an Event
            </div>
            <div class="card-body">
                <form method="POST">

                    <div class="form-row">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon3">Event</span>
                            </div>
                            <?php
                                $query = "SELECT name, event_id 
                                            FROM `event` 
                                            WHERE host_id = $userID";
                                $result = $connection->query($query);
                            ?>
                            <select name="eventList" class="form-control">
                            <?php 
                                while ($row = $result->fetch_assoc()) {
                            ?>
                            <option value="<?php echo $row['name'];?>">
                                <?php echo $row['name'];?>
                            </option>
                            <?php
                                }
                            ?>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-3 mb-3">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">Name</span>
                                </div>
                                <input type="text" class="form-control" name="eventName">
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">Start Date</span>
                                </div>
                                <input type="text" class="form-control" name="start" placeHolder="YYYY-MM-DD HH:MM:SS">
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">End Date</span>
                                </div>
                                <input type="text" class="form-control" name="end" placeHolder="YYYY-MM-DD HH:MM:SS">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="submit" name="updateEvent" class="btn btn-primary" value="Update">
                    </div>
                </form>
            </div>
            <!-- PHP for SQL -->
            <?php
                if (isset($_POST["updateEvent"])) {
                    $event = $_POST["eventList"];
                    $query = "SELECT e.event_id
                                FROM `event` e
                                WHERE e.name = '$event' AND e.host_id = $userID";
                    $result = $connection->query($query);
                    $id = $result->fetch_assoc();
                    $eventID = $id["event_id"];
                    $name = $_POST["eventName"];
                    $startDate = $_POST["start"];
                    $endDate = $_POST["end"];
                    $updateQuery = "UPDATE `event`
                                    SET name = '$name', start_date = '$startDate', end_date = '$endDate'
                                    WHERE event_id = $eventID";
                    if ($connection->query($updateQuery) === TRUE) {
                        echo '<div class="card-body">
                            <div class="alert alert-success" role="alert">'
                                .$event. ' was successfully updated.
                            </div>
                            </div>';
                    } 
                    else {
                        echo '<div class="card-body">
                            <div class="alert alert-warning" role="alert">
                                Error updating ' .$event. '. Error: ' .$connection->error. '
                            </div>
                            </div>';
                    }
                }
            ?>      
        </div>

        <!-- Find Venues -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Search for Venues
            </div>
            <div class="card-body">
                <form class="form-inline" method="POST">
                    <div class="input-group mb-2 mr-sm-2">
                        <div class="input-group-prepend">
                            <div class="input-group-text">
                                Accomodates At Least
                            </div>
                        </div>
                        <input type="text" class="form-control" id="inlineFormInputGroupUsername2" name="capacity">
                    </div>
                    <div class="form-check mb-2 mr-sm-2">
                        <input class="form-check-input" type="checkbox" id="inlineFormCheck" name="minimum">
                        <label class="form-check-label" for="inlineFormCheck">
                            Minimum Capacity
                        </label>
                    </div>
                    <div class="form-check mb-2 mr-sm-2">
                        <input class="form-check-input" type="checkbox" id="inlineFormCheck" name="maximum">
                        <label class="form-check-label" for="inlineFormCheck">
                            Maximum Capacity
                        </label>
                    </div>
                    <div class="form-group">
                        <input type="submit" name="venueSearch" class="btn btn-primary" value="Search">
                    </div>
                </form>
            </div>
            <!-- add php -->
            <?php
                if (isset($_POST["venueSearch"])) {
                    $atLeast = $_POST["capacity"];
                    if ($atLeast != "") {
                        $atleastQuery = "SELECT *
                                        FROM venue1 
                                        WHERE venue1.capacity >= '$atLeast'";
                        $result = $connection->query($atleastQuery);
                        if ($result->num_rows > 0) {
                            echo '<div class="card-body">
                                <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Name</th>
                                        <th scope="col">Address</th>
                                        <th scope="col">Capacity</th>
                                    <tr>
                                </thead>
                                <tbody>';
                        while ($rows = $result->fetch_assoc()) {
                            echo '<tr>
                                    <td>' .$rows["name"]. '</td>
                                    <td>' .$rows["address"]. '</td>
                                    <td>' .$rows["capacity"]. '</td>
                                    </tr>';
                        }
                        echo '</tbody>
                            </table>
                            </div>';
                        }
                        else {
                            echo '<div class="card-body">
                                <div class="alert alert-warning" role="alert">
                                    No Results Found.
                                </div>
                                </div>';
                        }
                    }
                    else if (isset($_POST["minimum"])) {
                        $minimumQuery = "SELECT *
                                        FROM venue1 v1
                                        WHERE NOT EXISTS (SELECT *
                                                            FROM venue1 v2
                                                            WHERE v2.capacity < v1.capacity)";
                        $result = $connection->query($minimumQuery);
                        if ($result->num_rows > 0) {
                            echo '<div class="card-body">
                                <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Name</th>
                                        <th scope="col">Address</th>
                                        <th scope="col">Capacity</th>
                                    <tr>
                                </thead>
                                <tbody>';
                        while ($rows = $result->fetch_assoc()) {
                            echo '<tr>
                                    <td>' .$rows["name"]. '</td>
                                    <td>' .$rows["address"]. '</td>
                                    <td>' .$rows["capacity"]. '</td>
                                    </tr>';
                        }
                        echo '</tbody>
                            </table>
                            </div>';
                        }
                        else {
                            echo '<div class="card-body">
                                <div class="alert alert-warning" role="alert">
                                    No Results Found.
                                </div>
                                </div>';
                        }
                    }
                    else if (isset($_POST["maximum"])) {
                        $maximumQuery = "SELECT *
                                        FROM venue1 v1
                                        WHERE NOT EXISTS (SELECT *
                                                            FROM venue1 v2
                                                            WHERE v2.capacity > v1.capacity)";
                        $result = $connection->query($maximumQuery);
                        if ($result->num_rows > 0) {
                            echo '<div class="card-body">
                                <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Name</th>
                                        <th scope="col">Address</th>
                                        <th scope="col">Capacity</th>
                                    <tr>
                                </thead>
                                <tbody>';
                        while ($rows = $result->fetch_assoc()) {
                            echo '<tr>
                                    <td>' .$rows["name"]. '</td>
                                    <td>' .$rows["address"]. '</td>
                                    <td>' .$rows["capacity"]. '</td>
                                    </tr>';
                        }
                        echo '</tbody>
                            </table>
                            </div>';
                        }
                        else {
                            echo '<div class="card-body">
                                <div class="alert alert-warning" role="alert">
                                    No Results Found.
                                </div>
                                </div>';
                        }
                    }
                }
            ?>
        </div>

        <!-- Find people that attend one of your events -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Find People Attending One of Your Events
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-group">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon3">Event</span>
                            </div>
                            <?php
                                $query = "SELECT name 
                                            FROM `event` 
                                            WHERE host_id = $userID";
                                $result = $connection->query($query);
                            ?>
                            <select name="eventList" class="form-control">
                            <?php 
                                while ($row = $result->fetch_assoc()) {
                            ?>
                            <option value="<?php echo $row['name'];?>">
                                <?php echo $row['name'];?>
                            </option>
                            <?php
                                }
                            ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="submit" name="peopleAttending" class="btn btn-primary" value="Search">
                    </div>
                </form>
            </div>
            <!-- add php for sql -->
            <?php
                if(isset($_POST["peopleAttending"])) {
                    $event = $_POST["eventList"];
                    $query = "SELECT e.event_id
                                FROM `event` e
                                WHERE e.name = '$event' AND e.host_id = $userID";
                    $result = $connection->query($query);
                    $id = $result->fetch_assoc();
                    $eventID = $id["event_id"];
                    $query = "SELECT DISTINCT r3.name, r2.address, r1.email
                                FROM `event` e, regularuser3 r3, regularuser2 r2, regularuser1 r1, purchased p, isfor i, ticket t
                                WHERE e.event_id = $eventID AND e.event_id = i.event_id AND t.ticket_id = i.ticket_id
                                AND i.ticket_id = p.ticket_id AND p.user_id = r3.user_id AND r3.name = r2.name
                                AND r3.name = r1.name";
                    $result = $connection->query($query);
                    if ($result->num_rows > 0) {
                        echo '<div class="card-body">
                                <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Attendee</th>
                                        <th scope="col">Address</th>
                                        <th scope="col">Email</th>
                                    <tr>
                                </thead>
                                <tbody>';
                        while ($rows = $result->fetch_assoc()) {
                            echo '<tr>
                                    <td>' .$rows["name"]. '</td>
                                    <td>' .$rows["address"]. '</td>
                                    <td>' .$rows["email"]. '</td>
                                    </tr>';
                        }
                        echo '</tbody>
                            </table>
                            </div>';
                    }
                    else {
                        echo '<div class="card-body">
                            <div class="alert alert-warning" role="alert">
                                No Results Found.
                            </div>
                            </div>';
                    }
                }
            ?>
        </div>

        <!-- Find contact info for all performers of your event -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Get Emails of Performers For an Event you Host
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-group">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon3">Event</span>
                            </div>
                            <?php
                                $query = "SELECT name 
                                            FROM `event` 
                                            WHERE host_id = $userID";
                                $result = $connection->query($query);
                            ?>
                            <select name="eventList" class="form-control">
                            <?php 
                                while ($row = $result->fetch_assoc()) {
                            ?>
                            <option value="<?php echo $row['name'];?>">
                                <?php echo $row['name'];?>
                            </option>
                            <?php
                                }
                            ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="submit" name="performerContactInfo" class="btn btn-primary" value="Search">
                    </div>
                </form>
            </div>
            <!-- add php for sql -->
            <?php
                if(isset($_POST["performerContactInfo"])) {
                    $event = $_POST["eventList"];
                    $query = "SELECT e.event_id
                                FROM `event` e
                                WHERE e.name = '$event' AND e.host_id = $userID";
                    $result = $connection->query($query);
                    $id = $result->fetch_assoc();
                    $eventID = $id["event_id"];
                    $query = "SELECT p.name, p.contact
                                FROM `event` e, performsat pat, performer p
                                WHERE e.event_id = $eventID AND e.event_id = pat.event_id 
                                AND pat.performer_id = p.performer_id";
                    $result = $connection->query($query);
                    if ($result->num_rows > 0) {
                        echo '<div class="card-body">
                                <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Performer</th>
                                        <th scope="col">Email</th>
                                    <tr>
                                </thead>
                                <tbody>';
                        while ($rows = $result->fetch_assoc()) {
                            echo '<tr>
                                    <td>' .$rows["name"]. '</td>
                                    <td>' .$rows["contact"]. '</td>
                                    </tr>';
                        }
                        echo '</tbody>
                            </table>
                            </div>';
                    }
                    else {
                        echo '<div class="card-body">
                            <div class="alert alert-warning" role="alert">
                                No Results Found.
                            </div>
                            </div>';
                    }
                }
            ?>
        </div>

        <!-- Delete Event -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Delete an Event
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-group">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon3">Event</span>
                            </div>
                            <?php
                                $query = "SELECT name 
                                            FROM `event` 
                                            WHERE host_id = $userID";
                                $result = $connection->query($query);
                            ?>
                            <select name="eventList" class="form-control">
                            <?php 
                                while ($row = $result->fetch_assoc()) {
                            ?>
                            <option value="<?php echo $row['name'];?>">
                                <?php echo $row['name'];?>
                            </option>
                            <?php
                                }
                            ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="submit" name="deleteEvent" class="btn btn-warning" value="Delete">
                    </div>
                </form>
            </div>
            <!-- add php -->
            <?php
                if(isset($_POST["deleteEvent"])) {
                    $event = $_POST["eventList"];
                    $query = "SELECT e.event_id
                                FROM `event` e
                                WHERE e.name = '$event' AND e.host_id = $userID";
                    $result = $connection->query($query);
                    $id = $result->fetch_assoc();
                    $eventID = $id["event_id"];
                    $deleteQuery = "DELETE 
                                    FROM `event`
                                    WHERE event_id = $eventID";
                    if ($connection->query($deleteQuery) === TRUE) {
                        echo '<div class="card-body">
                            <div class="alert alert-success" role="alert">'
                                .$event. ' was successfully deleted.
                            </div>
                            </div>';
                    }
                    else {
                        echo '<div class="card-body">
                            <div class="alert alert-warning" role="alert">
                                Error deleting ' .$event. '
                            </div>
                            </div>';
                    }
                }
            ?>
        </div>
    </body>
</html>