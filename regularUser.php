<?php
    include 'connect.php';
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
                            echo '<td>' .$rows["time_block_start"]. '</td>
                                    <td>' .$rows["time_block_end"]. '</td>';
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
        </body>
</html>