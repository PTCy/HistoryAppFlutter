<?php
include('connectDB.php');

$user_id = $_POST['user_id'];

$sql = "SELECT * FROM tbl_user WHERE id_user = '$user_id' ";
$query = mysqli_query($con, $sql);
$result = array();
while ($rs = $query->fetch_assoc()) {
    $result[] = $rs;
}
//print_r($result);
echo json_encode($result);

?>