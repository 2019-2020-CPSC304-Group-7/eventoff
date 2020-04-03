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
        <!-- Forms for user queries -->

        <div class="alert alert-success" role="alert">
            <?php
                echo '<h5>Welcome <b>' .$name. '</b></h5>';
            ?>
        </div>
        <!-- Display Schedule form -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Check Schedule
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-group">
                        <input type="submit" name="schedule" class="btn btn-primary" value="Display Schedule">
                    </div>
                </form>
            </div>
            <!-- PHP for SQL -->
            <?php
                if(isset($_POST["schedule"])) {
                    $query = "select e.name, e.start_date, e.end_date
                                from purchased p, isfor i, `event` e
                                where p.user_id = $userID AND p.ticket_id = i.ticket_id
                                AND i.event_id = e.event_id";
                    $result = $connection->query($query);
                    if ($result->num_rows > 0) {
                        echo '<div class="card-body">
                                <table class="table">
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
        </div>

        <!-- Find ticket by price form -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Find Tickets By Price
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-row">
                        <div class="col-md-3 mb-3">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" id="basic-addon3">Minimum Price</span>
                                </div>
                                <input name="minimum" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" id="basic-addon3">Maximum Price</span>
                                </div>
                                <input name="maximum" type="text" class="form-control">
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
                    $query = "select t.ticket_id as id, t.price as pr, e.name as nm
                                from ticket t, isfor i, `event` e
                                where t.price >= $min AND t.price <= $max
                                AND t.ticket_id = i.ticket_id AND i.event_id = e.event_id
                                AND t.ticket_id not in (select p.ticket_id
                                                        from purchased p)";
                    $result = $connection->query($query);
                    if ($result->num_rows > 0) {
                        echo '<div class="card-body">
                                    <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Ticket ID</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Event</th>
                                        <tr>
                                    </thead>
                                    <tbody>';
                        while ($rows = $result->fetch_assoc()) {
                            echo '<tr>
                                    <td>' .$rows["id"]. '</td>
                                    <td>' .$rows["pr"]. '</td>
                                    <td>' .$rows["nm"]. '</td>
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

        <!-- Host's rating for a given event -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Check a Host's Rating
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-group">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon3">Event</span>
                            </div>
                            <?php
                                $query = "select name from `event`";
                                $result = $connection->query($query);
                            ?>
                            <select name="eventList1" class="form-control">
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
                    $query = "select h.name as n1, h.email, h.rating, e.name as n2
                                from host2 h, event e
                                where h.host_id = e.host_id AND e.name = '$event'";
                    $result = $connection->query($query);
                    if ($result->num_rows > 0) {
                        echo '<div class="card-body">
                                    <table class="table">
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
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Find The Cheapest Ticket
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-group">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon3">Event</span>
                            </div>
                            <?php
                                $query = "select name from `event`";
                                $result = $connection->query($query);
                            ?>
                            <select name="eventList2" class="form-control">
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
                    $getEventID = "select e.event_id
                                from `event` e
                                where e.name = '$event'";
                    $eventResult = $connection->query($getEventID);
                    $id = $eventResult->fetch_assoc();
                    $eventID = $id["event_id"];
                    $_SESSION["eventID"] = $eventID;
                    $query = "select t.ticket_id, v.name as n1, e.name as n2, MIN(t.price) as price
                                from sells s, ticket t, isfor i, ticketvendor2 v, event e
                                where s.ticket_id = t.ticket_id AND s.ticket_id = i.ticket_id 
                                AND e.event_id = $eventID AND i.event_id = e.event_id AND s.vendor_id = v.vendor_id
                                AND t.ticket_id not in (select p.ticket_id from purchased p)
                                group by s.vendor_id";
                    $_SESSION["cheapestTicketDataQuery"] = $query;
                    $result = $connection->query($query);
                    if ($result->num_rows > 0) {
                        echo '<div class="card-body">
                                    <table class="table">
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
                                            <input type="hidden" name="ticket" value="'.$ticketID.'"/>
                                            <input type="submit" name="book" class="btn btn-primary Book" value="Book">
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
                if (isset($_POST["book"])) {
                    $ticketID =  $_POST["ticket"];
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