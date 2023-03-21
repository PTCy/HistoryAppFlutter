<?php
include('connectDB.php');

if (
    isset($_POST["name"]) &&

    isset($_POST["email"]) &&

    isset($_POST["password"])&&
    
    isset($_POST["user_id"])

) {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $user_id = $_POST['user_id'];
} else {
    echo json_encode("Failed No Data");
    return;
}

$sql = "UPDATE tbl_user
  SET name = '$name', email = '$email', password = '$password'
  WHERE id_user = '" . $user_id . "'";



if (mysqli_query($con, $sql)) {
    echo json_encode("Success");
} else {
    echo json_encode("Failed");
    return;
}

?>