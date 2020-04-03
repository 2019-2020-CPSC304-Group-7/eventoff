<html lang="eng">
    <head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <title>EventOFF</title>
    </head>
    <body style="background-color: black;">
        <!-- Form for logging in -->
        <div class="container">
            <div class="card text-white bg-dark mb-3" style="margin: 20 20 20 20;">
                <div class="card-header">
                    <b>User ID</b>
                </div>
                <div class="card-body">
                    <form method="POST">
                        <div class="form-group">
                            <input class="form-control text-white bg-dark" name="userID" type="text" placeholder="Enter your user ID">
                        </div>
                        <div class="form-group">
                            <input type="submit" name="login" class="btn btn-primary" value="Login">
                        </div>
                    </form>
                </div>
                <!-- PHP for SQL -->
                <?php
                    include 'connect.php';
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
                                $name = $username["name"];
                                header("location: host.php?user=$name&userID=$userID");
                            }
                        }
                        else {
                            $username = $result->fetch_assoc();
                            $name = $username["name"];
                            header("location: regularUser.php?user=$name&userID=$userID");
                        }
                    }
                ?>
            </div>
        </div>
    </body>
</html>