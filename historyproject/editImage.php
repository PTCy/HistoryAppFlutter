<?php
include('connectDB.php');
if (

    isset($_POST["user_id"])

) {

    $image = $_FILES['image']['name'];
    $imagePath = 'uploadProfile/' . $image;
    $tmp_name = $_FILES['image']['tmp_name'];
    $user_id = $_POST['user_id'];

} else {
    echo json_encode("Failed No Data");
    return;
}




move_uploaded_file($tmp_name, $imagePath);

// $sql = "UPDATE users SET pic VALUES('" . $image . "') WHERE userid = '" . $userid . "'";
$sql = "UPDATE tbl_user SET img_user = '" . $image . "' WHERE id_user = '" . $user_id . "'";



if (mysqli_query($con, $sql)) {
    echo json_encode("Success"); 

} else {
    echo json_encode("Failed");

    return;
}