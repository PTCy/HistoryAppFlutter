<?php 

    include('connectDB.php');

    $id_favour = $_POST['id_favour'];

    $con->query("DELETE FROM tbl_favour WHERE id_favour = '$id_favour'");

?>