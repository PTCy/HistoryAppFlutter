<?php 
    include('connectDB.php');

    $user_id = $_POST['user_id'];
	$id_person = $_POST['id_person'];


    $con->query("DELETE FROM tbl_favour WHERE id_user = '$user_id' AND id_person = '$id_person' ");


?>