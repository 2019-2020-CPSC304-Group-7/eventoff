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
                        <input type="submit" name="schedule" class="btn btn-primary">
                    </div>
                </form>
            </div>
            <!-- PHP for SQL -->
            <?php
                if(isset($_POST["schedule"])) {
                    $query = "select time_block_start, time_block_end
                                from userschedule 
                                where user_id = $userID";
                    $result = $connection->query($query);
                    if ($result->num_rows > 0) {
                        echo '<div class="card-body">
                                <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Start Time</th>
                                        <th scope="col">End Time</th>
                                    <tr>
                                </thead>
                                <tbody>';
                        while ($rows = $result->fetch_assoc()) {
                            echo '<tr>
                                    <td>' .$rows["time_block_start"]. '</td>
                                    <td>' .$rows["time_block_end"]. '</td>
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
                        <input type="submit" name="findTicket" class="btn btn-primary">
                    </div>
                </form>
            </div>
            <!-- Add php for SQL -->
            <?php 
                if(isset($_POST["findTicket"])) {
                    $min = $_POST["minimum"];
                    $max = $_POST["maximum"];
                    $query = "select t.ticket_id as id, t.price as pr, e.name as nm
                                from ticket t, isFor i, `event` e
                                where t.price >= $min AND t.price <= $max
                                AND t.ticket_id = i.ticket_id AND i.event_id = e.event_id";
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
                        <input type="submit" name="hostRating" class="btn btn-primary">
                    </div>
                </form>
            </div>    
            <!-- Add php for SQL -->
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

        <!-- Find the cheapest ticket for an event -->
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
                        <input type="submit" name="cheapestTicket" class="btn btn-primary">
                    </div>
                </form>
            </div>
            <!-- Add php for SQL -->
            <?php 
                if(isset($_POST["cheapestTicket"])) {
                    $event = $_POST["eventList2"];
                    $query = " select t1.ticket_id, t1.price, e1.name
                                from ticket t1, `event` e1, isfor i1
                                where t1.ticket_id = i1.ticket_id AND i1.event_id = e1.event_id AND e1.name = '$event' AND
                                not exists (select t2.ticket_id
                                            from ticket t2, `event` e2, isfor i2
                                            where t2.price < t1.price AND t2.ticket_id = i2.ticket_id 
                                            AND i2.event_id = e2.event_id AND e2.name = '$event')";
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
                                    <td>' .$rows["ticket_id"]. '</td>
                                    <td>' .$rows["price"]. '</td>
                                    <td>' .$rows["name"]. '</td>
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
        </body>
</html>