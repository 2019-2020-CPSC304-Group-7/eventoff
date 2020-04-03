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

        <!-- Display all events of this host -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Show all Events
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-group">
                        <input type="submit" name="events" class="btn btn-primary">
                    </div>
                </form>
            </div>
            <!-- PHP for SQL -->
            <?php 
                if(isset($_POST["events"])) {
                    $query = "select e.name as n1, e.start_date, e.end_date, e.ranking, v.name as n2, count(i.ticket_id) as attendance
                                from `event` e, bookedat b, venue2 v, isfor i
                                where e.host_id = $userID AND e.event_id = b.event_id
                                AND b.venue_id = v.venue_id AND e.event_id = i.event_id
                                group by e.name
                                order by Attendance desc";
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
        </div>

        <!-- Add a new event -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Add a New Event
            </div>
            <div class="card-body">
                <form method="POST">

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
                                <input type="text" class="form-control" name="start" placeHolder="YYYY-MM-DD">
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">End Date</span>
                                </div>
                                <input type="text" class="form-control" name="end" placeHolder="YYYY-MM-DD">
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-3 mb-3">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">Performer</span>
                                </div>
                                <?php
                                $query = "select name from `performer`";
                                $result = $connection->query($query);
                                ?>
                                <select name="performer" class="form-control">
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
                        <div class="col-md-3 mb-3">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">Venue</span>
                                </div>
                                <?php
                                $query = "select name from `venue1`";
                                $result = $connection->query($query);
                                ?>
                                <select name="venue" class="form-control">
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
                        <div class="col-md-3 mb-3">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">Category</span>
                                </div>
                                <?php
                                $query = "select name from `eventCategory`";
                                $result = $connection->query($query);
                                ?>
                                <select name="category" class="form-control">
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
                    </div>

                    <div class="form-row">
                        <div class="col-md-3 mb-3">
                            <input type="submit" class="btn btn-primary" name="addEvent">
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- add php -->

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
                                $query = "select name from `event` where host_id = $userID";
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
                        <input type="submit" name="deleteEvent" class="btn btn-primary">
                    </div>
                </form>
            </div>
            <!-- add php -->
            <?php
                if(isset($_POST["deleteEvent"])) {
                    $event = $_POST["eventList"];
                    $query = "select e.event_id
                                from `event` e
                                where e.name = '$event' AND e.host_id = $userID";
                    $result = $connection->query($query);
                    $id = $result->fetch_assoc();
                    $eventID = $id["event_id"];
                    $deleteQuery = "delete 
                                    from `event`
                                    where event_id = $eventID";
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
                                $query = "select name from `event` where host_id = $userID";
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
                                <input type="text" class="form-control" name="start" placeHolder="YYYY-MM-DD">
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">End Date</span>
                                </div>
                                <input type="text" class="form-control" name="end" placeHolder="YYYY-MM-DD">
                            </div>
                        </div>
                    </div>

                    <!-- <div class="form-row">
                        <div class="col-md-3 mb-3">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">Performer</span>
                                </div>
                                <?php
                                $query = "select name from `performer`";
                                $result = $connection->query($query);
                                ?>
                                <select name="performer" class="form-control">
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
                        <div class="col-md-3 mb-3">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">Venue</span>
                                </div>
                                <?php
                                $query = "select name from `venue1`";
                                $result = $connection->query($query);
                                ?>
                                <select name="venue" class="form-control">
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
                        <div class="col-md-3 mb-3">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">Category</span>
                                </div>
                                <?php
                                $query = "select name from `eventCategory`";
                                $result = $connection->query($query);
                                ?>
                                <select name="category" class="form-control">
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
                    </div> -->
                    
                    <div class="form-group">
                        <input type="submit" name="updateEvent" class="btn btn-primary">
                    </div>
                </form>
            </div>
            <!-- PHP for SQL -->
            <?php
                if (isset($_POST["updateEvent"])) {
                    $event = $_POST["eventList"];
                    $query = "select e.event_id
                                from `event` e
                                where e.name = '$event' AND e.host_id = $userID";
                    $result = $connection->query($query);
                    $id = $result->fetch_assoc();
                    $eventID = $id["event_id"];
                    $name = $_POST["eventName"];
                    $startDate = $_POST["start"];
                    $endDate = $_POST["end"];
                    $updateQuery = "update `event`
                                    set name = '$name', start_date = '$startDate', end_date = '$endDate'
                                    where event_id = $eventID";
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
                        <input type="submit" name="venueSearch" class="btn btn-primary">
                    </div>
                </form>
            </div>
            <!-- add php -->
            <?php
                if (isset($_POST["venueSearch"])) {
                    $atLeast = $_POST["capacity"];
                    if ($atLeast != "") {
                        $atleastQuery = "select *
                                        from venue1 
                                        where venue1.capacity >= '$atLeast'";
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
                        $minimumQuery = "select *
                                        from venue1 v1
                                        where not exists (select *
                                                            from venue1 v2
                                                            where v2.capacity < v1.capacity)";
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
                        $maximumQuery = "select *
                                        from venue1 v1
                                        where not exists (select *
                                                            from venue1 v2
                                                            where v2.capacity > v1.capacity)";
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

        <!-- Get all people attending all events of a host -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Get All People Attending All Events Hosted By You
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-group">
                        <input type="submit" name="allPeople" class="btn btn-primary">
                    </div>
                </form>
            </div>
        </div>
        <!-- add php -->

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
                                $query = "select name from `event` where host_id = $userID";
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
                        <input type="submit" name="performerContactInfo" class="btn btn-primary">
                    </div>
                </form>
            </div>
            <!-- add php for sql -->
            <?php
                if(isset($_POST["performerContactInfo"])) {
                    $event = $_POST["eventList"];
                    $query = "select e.event_id
                                from `event` e
                                where e.name = '$event' AND e.host_id = $userID";
                    $result = $connection->query($query);
                    $id = $result->fetch_assoc();
                    $eventID = $id["event_id"];
                    $query = "select p.name, p.contact
                                from `event` e, performsat pat, performer p
                                where e.event_id = $eventID AND e.event_id = pat.event_id 
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
    </body>
</html>