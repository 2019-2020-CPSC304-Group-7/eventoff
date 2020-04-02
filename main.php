<html lang="eng">
    <head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <title>EventOFF</title>
    </head>
    <body>
        <!-- Form for logging in -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                User ID
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-group">
                        <input class="form-control" name="userID" type="text" placeholder="Enter your user ID">
                    </div>
                    <div class="form-group">
                        <input type="submit" name="login" class="btn btn-primary">
                    </div>
                </form>
            </div>
            <?php
                include 'connect.php';
                $regularUser = false;
                $host = false;
                $connection = openConnection();
                if (isset($_POST["login"])) {
                    $userID = $_POST['userID'];
                    $sqlForUser = "select name from regularuser3 where user_id = $userID";
                    $sqlForHost = "select name from host2 where host_id = $userID";
                    $result = $connection->query($sqlForUser);

                    if ($result->num_rows < 1) {
                        $result = $connection->query($sqlForHost);
                        if ($result->num_rows < 1) {
                            echo '<div class="card-body">
                                    <div class="alert alert-warning" role="alert">
                                        Invalid user ID. Please try again.
                                    </div>
                                </div>';
                        }
                        else {
                            $username = $result->fetch_assoc();
                            $host = true;
                            echo '<div class="card-body">
                                    <div class="alert alert-success" role="alert">
                                        Welcome <b>' .$username["name"]. '</b>
                                    </div>
                                </div>';
                        }
                    }
                    else {
                        $username = $result->fetch_assoc();
                        $regularUser = true;
                        echo '<div class="card-body">
                                    <div class="alert alert-success" role="alert">
                                        Welcome <b>' .$username["name"]. '</b>
                                    </div>
                                </div>';
                    }
                }
            ?>
        </div>

        <!-- Forms for user queries -->
        <?php
            if ($regularUser) { 
        ?>

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
        </div>
        

        <!-- Find ticket by price form -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Find Tickets By Price
            </div>
            <div class="card-body">
                <form method="POST">
                    <div class="form-group">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon3">$</span>
                            </div>
                            <input name="priceRangeLow" type="text" class="form-control">
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon3">$</span>
                            </div>
                            <input name="priceRangeHigh" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="submit" name="findTicket" class="btn btn-primary">
                    </div>
                </form>
            </div>
        </div>
        <!-- Add php for SQL -->

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
                            <select name="eventList[]" class="form-control">
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
        </div>
        <!-- Add php for SQL -->

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
                            <select name="eventList[]" class="form-control">
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
        </div>
        <!-- Add php for SQL -->
        <?php 
            } 
        ?>

        <!-- Forms for host queries -->
        <?php 
            if ($host) {
        ?>

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
        </div>
        <!-- add php -->

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
                    
                    <div class="form-group">
                        <input type="submit" name="deleteEvent" class="btn btn-primary">
                    </div>
                </form>
            </div>
        </div>
        <!-- add php -->

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
                        <input type="submit" name="venue" class="btn btn-primary">
                    </div>
                </form>
            </div>
        </div>
        <!-- add php -->

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

        <!-- Find attendees email for an event -->
        <div class="card" style="margin: 20 20 20 20;">
            <div class="card-header">
                Get Emails of People Attending an Event You Host
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
                        <input type="submit" name="peopleContactInfo" class="btn btn-primary">
                    </div>
                </form>
            </div>
        </div>
        <!-- add php for sql -->

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
        </div>
        <!-- add php for sql -->
        <?php
            }
        ?>
    </body>
</html>