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
        <body style="background-color: black;">
        <!-- Forms for user queries -->

        <div class="container">
            <div class="alert alert-success" role="alert">
                <?php
                    echo '<h5>Welcome <b>' .$name. '</b></h5>';
                ?>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="card text-white bg-dark mb-3" style="margin: 20 20 20 20;">
            <div class="card-header">
                <b>Quick Actions</b>
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-row">
                        <div class="col-md-3 mb-3">
                            <input type="submit" name="schedule" class="btn btn-primary" value="Check Your Schedule">
                        </div>
                        <div class="col-md-3 mb-3">
                            <input type="submit" name="events" class="btn btn-primary" value="Search All Events">
                        </div>
                    </div>
                </form>
            </div>

            <!-- PHP for Schedule -->
            <?php
                if(isset($_POST["schedule"])) {
                    $query = "SELECT DISTINCT e.name, e.start_date, e.end_date
                                FROM purchased p, isfor i, `event` e
                                WHERE p.user_id = $userID AND p.ticket_id = i.ticket_id
                                AND i.event_id = e.event_id
                                ORDER BY e.start_date";
                    $result = $connection->query($query);
                    if ($result->num_rows > 0) {
                        echo '<div class="card-body">
                                <table class="table  text-white bg-dark">
                                <thead>
                                    <tr>
                                        <th scope="col">Event</th>
                                        <th scope="col">Start Time</th>
                                        <th scope="col">End Time</th>
                                    <tr>
                                </thead>
                                <tbody>';
                        while ($rows = $result->fetch_assoc()) {
                            echo '<tr>
                                    <td>' .$rows["name"]. '</td>
                                    <td>' .$rows["start_date"]. '</td>
                                    <td>' .$rows["end_date"]. '</td>
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

            <!-- PHP for SQL -->
            <?php
                if (isset($_POST["events"])) {
                    $getEvents = "SELECT e.name as n1, e.start_date, e.end_date, e.ranking as r1, h.name as n2, h.rating as r2, i.category
                                    FROM `event` e, host2 h, iscategory i
                                    WHERE e.host_id = h.host_id AND i.event_id = e.event_id
                                    ORDER BY e.start_date ASC";
                    $eventsResult = $connection->query($getEvents);
                    if ($eventsResult->num_rows > 0) {
                        echo '<div class="card-body">
                                <table class="table  text-white bg-dark">
                                <thead>
                                    <tr>
                                        <th scope="col">Event</th>
                                        <th scope="col">Start Time</th>
                                        <th scope="col">End Time</th>
                                        <th scope="col">Event Rating</th>
                                        <th scope="col">Hosted By</th>
                                        <th scope="col">Host Rating</th>
                                        <th scope="col">Category</th>
                                    <tr>
                                </thead>
                                <tbody>';
                        while ($rows = $eventsResult->fetch_assoc()) {
                            echo '<tr>
                                    <td>' .$rows["n1"]. '</td>
                                    <td>' .$rows["start_date"]. '</td>
                                    <td>' .$rows["end_date"]. '</td>
                                    <td>' .$rows["r1"]. '</td>
                                    <td>' .$rows["n2"]. '</td>
                                    <td>' .$rows["r2"]. '</td>
                                    <td>' .$rows["category"]. '</td>
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

        <!-- Find ticket by price form -->
        <div class="card text-white bg-dark mb-3" style="margin: 20 20 20 20;">
            <div class="card-header">
                <b>Find Tickets By Price</b>
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-row">
                        <div class="col-md-3 mb-3">
                            <div class="input-group mb-3 text-white bg-dark">
                                <div class="input-group-prepend text-white bg-dark">
                                    <span class="input-group-text text-white bg-dark" id="basic-addon3">Minimum Price</span>
                                </div>
                                <input name="minimum" type="text" class="form-control text-white bg-dark">
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="input-group mb-3 text-white bg-dark">
                                <div class="input-group-prepend text-white bg-dark">
                                    <span class="input-group-text text-white bg-dark" id="basic-addon3">Maximum Price</span>
                                </div>
                                <input name="maximum" type="text" class="form-control text-white bg-dark">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="submit" name="findTicket" class="btn btn-primary" value="Search">
                    </div>
                </form>
            </div>
            <!-- PHP for SQL -->
            <?php 
                if(isset($_POST["findTicket"])) {
                    $min = $_POST["minimum"];
                    $max = $_POST["maximum"];
                    $query = "SELECT t.ticket_id as id, t.price as pr, e.name as nm1, v.name as nm2
                                FROM ticket t, isfor i, `event` e, ticketvendor2 v, sells s
                                WHERE t.price >= $min AND t.price <= $max
                                AND t.ticket_id = i.ticket_id AND i.event_id = e.event_id
                                AND s.ticket_id = t.ticket_id AND s.vendor_id = v.vendor_id
                                AND t.ticket_id NOT IN (SELECT p.ticket_id
                                                        FROM purchased p)";
                    $result = $connection->query($query);
                    if ($result->num_rows > 0) {
                        echo '<div class="card-body">
                                    <table class="table  text-white bg-dark">
                                    <thead>
                                        <tr>
                                            <th scope="col">Event</th>
                                            <th scope="col">Vendor</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Book Ticket</th>
                                        <tr>
                                    </thead>
                                    <tbody>';
                        while ($rows = $result->fetch_assoc()) {
                            echo '<tr>
                                    <td>' .$rows["nm1"]. '</td>
                                    <td>' .$rows["nm2"]. '</td>
                                    <td>' .$rows["pr"]. '</td>
                                    <td> 
                                        <form method="POST">
                                            <input type="hidden" name="ticketRange" value="' .$rows["id"]. '" />
                                            <input type="submit" name="bookTicketByRange" class="btn btn-primary" value="Book">
                                        </form>
                                    </td>
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
                if (isset($_POST["bookTicketByRange"])) {
                    $ticketID =  $_POST["ticketRange"];
                    $addToPurchased = "INSERT INTO purchased(user_id, ticket_id)
                                        VALUES($userID, $ticketID)";
                    if ($connection->query($addToPurchased) === FALSE) {
                            echo '<div class="card-body">
                                    <div class="alert alert-warning" role="alert">
                                        Could Not book the ticket. Please try again.
                                    </div>
                                    </div>';
                    }
                    else {
                        echo '<div class="card-body">
                                <div class="alert alert-success" role="alert">
                                    Booking Complete.
                                </div>
                                </div>';
                    }
                }
            ?>
        </div>

        <!-- Host's rating for a given event -->
        <div class="card text-white bg-dark mb-3" style="margin: 20 20 20 20;">
            <div class="card-header">
                <b>Check a Host's Rating</b>
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-group">
                        <div class="input-group mb-3 text-white bg-dark">
                            <div class="input-group-prepend text-white bg-dark">
                                <span class="input-group-text text-white bg-dark" id="basic-addon3">Event</span>
                            </div>
                            <?php
                                $query = "SELECT name 
                                            FROM `event`";
                                $result = $connection->query($query);
                            ?>
                            <select name="eventList1" class="form-control text-white bg-dark">
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
                        <input type="submit" name="hostRating" class="btn btn-primary" value="Search">
                    </div>
                </form>
            </div>    
            <!-- PHP for SQL -->
            <?php 
                if(isset($_POST["hostRating"])) {
                    $event = $_POST["eventList1"];
                    $query = "SELECT h.name as n1, h.email, h.rating, e.name as n2
                                FROM host2 h, event e
                                WHERE h.host_id = e.host_id AND e.name = '$event'";
                    $result = $connection->query($query);
                    if ($result->num_rows > 0) {
                        echo '<div class="card-body">
                                    <table class="table  text-white bg-dark">
                                    <thead>
                                        <tr>
                                            <th scope="col">Host</th>
                                            <th scope="col">Email Address</th>
                                            <th scope="col">Rating</th>
                                            <th scope="col">Event</th>
                                        <tr>
                                    </thead>
                                    <tbody>';
                        while ($rows = $result->fetch_assoc()) {
                            echo '<tr>
                                    <td>' .$rows["n1"]. '</td>
                                    <td>' .$rows["email"]. '</td>
                                    <td>' .$rows["rating"]. '</td>
                                    <td>' .$rows["n2"]. '</td>
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

        <!-- Find the cheapest ticket for an event and Book-->
        <div class="card text-white bg-dark mb-3" style="margin: 20 20 20 20;">
            <div class="card-header">
                <b>Find The Cheapest Ticket</b>
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-group">
                        <div class="input-group mb-3 text-white bg-dark">
                            <div class="input-group-prepend text-white bg-dark">
                                <span class="input-group-text text-white bg-dark" id="basic-addon3">Event</span>
                            </div>
                            <?php
                                $query = "SELECT name 
                                            FROM `event`";
                                $result = $connection->query($query);
                            ?>
                            <select name="eventList2" class="form-control text-white bg-dark">
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
                        <input type="submit" name="cheapestTicket" class="btn btn-primary" value="Search">
                    </div>
                </form>
            </div>
            <!-- PHP for SQL -->
            <?php 
                if(isset($_POST["cheapestTicket"])) {
                    $event = $_POST["eventList2"];
                    $getEventID = "SELECT e.event_id
                                FROM `event` e
                                WHERE e.name = '$event'";
                    $eventResult = $connection->query($getEventID);
                    $id = $eventResult->fetch_assoc();
                    $eventID = $id["event_id"];
                    $_SESSION["eventID"] = $eventID;
                    $query = "SELECT t.ticket_id, v.name as n1, e.name as n2, MIN(t.price) as price
                                FROM sells s, ticket t, isfor i, ticketvendor2 v, event e
                                WHERE s.ticket_id = t.ticket_id AND s.ticket_id = i.ticket_id 
                                AND e.event_id = $eventID AND i.event_id = e.event_id AND s.vendor_id = v.vendor_id
                                AND t.ticket_id NOT IN (SELECT p.ticket_id FROM purchased p)
                                GROUP BY s.vendor_id";
                    $_SESSION["cheapestTicketDataQuery"] = $query;
                    $result = $connection->query($query);
                    if ($result->num_rows > 0) {
                        echo '<div class="card-body">
                                    <table class="table  text-white bg-dark">
                                    <thead>
                                        <tr>
                                            <th scope="col">Vendor</th>
                                            <th scope="col">Event</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Book Ticket</th>
                                        <tr>
                                    </thead>
                                    <tbody>';
                        while ($rows = $result->fetch_assoc()) {
                            $ticketID = $rows["ticket_id"];
                            echo '<tr>
                                    <td>' .$rows["n1"]. '</td>
                                    <td>' .$rows["n2"]. '</td>
                                    <td>' .$rows["price"]. '</td>
                                    <td> <form method="POST">
                                            <input type="hidden" name="cheapestTicket" value="'.$ticketID.'"/>
                                            <input type="submit" name="bookCheapestTicket" class="btn btn-primary Book" value="Book">
                                         </form> 
                                    </td>
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
                if (isset($_POST["bookCheapestTicket"])) {
                    $ticketID =  $_POST["cheapestTicket"];
                    $addToPurchased = "insert into purchased(user_id, ticket_id)
                                        values($userID, $ticketID)";
                    if ($connection->query($addToPurchased) === FALSE) {
                            echo '<div class="card-body">
                                    <div class="alert alert-warning" role="alert">
                                        Could Not book the ticket. Please try again.
                                    </div>
                                    </div>';
                    }
                    else {
                        echo '<div class="card-body">
                                <div class="alert alert-success" role="alert">
                                    Booking Complete.
                                </div>
                                </div>';
                    }
                }
            ?>
        </div>
        </body>
</html>