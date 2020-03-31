<html lang="eng">
    <head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <title>EventOFF</title>
    </head>
    <body>
        <!-- Form for logging in -->
        <div class="col-sm-3">
            <form method="GET">
                <div class="form-group">
                    <label for="userID">User ID</label>
                    <input class="form-control" name="userID" type="text" placeholder="Enter your user ID">
                </div>
                <div class="form-group">
                    <input type="submit" name="login" class="btn btn-primary">
                </div>
            </form>
            <?php
                include 'connect.php';
                $connection = openConnection();
                if (isset($_GET["login"])) {
                    $userID = $_GET['userID'];
                    $sqlForUser = "select name from regularuser3 where user_id = $userID";
                    $sqlForHost = "select name from host2 where host_id = $userID";
                    $result = $connection->query($sqlForUser);

                    if ($result->num_rows < 1) {
                        $result = $connection->query($sqlForHost);
                        if ($result->num_rows < 1) {
                            echo "Invalid user ID. Please try again.";
                        }
                        else {
                            $username = $result->fetch_assoc();
                            echo "Welcome " . "<b>" .$username["name"]. "</b>";
                        }
                    }
                    else {
                        $username = $result->fetch_assoc();
                        echo "Welcome " . "<b>" .$username["name"]. "</b>";
                    }
                }
            ?>
        </div>

        <!-- Form for user queries -->
        <div class="col-sm-3">
            <p>Space for user queries.</p>
        </div>
    </body>
</html>