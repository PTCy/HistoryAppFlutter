<?php
include('connectDB.php');

    $user_id = $_POST['user_id'];
    $id_person = $_POST['id_person'];

    $sql = "SELECT * from tbl_favour WHERE id_user = '" . $user_id . "' AND id_person = '" . $id_person . "'";

    $result = mysqli_query($con, $sql);
    $count = mysqli_num_rows($result);



    if ($count > 0) {
        echo json_encode('failed');
    } else {
        $sql2 = "INSERT INTO tbl_favour (id_user, id_person) VALUES (?,?)";

        $statement = $con->prepare($sql2);
        $statement->bind_param('ss',$user_id, $id_person);

        if ($statement->execute()) {
            echo json_encode('success');
        } else {
            echo json_encode('fail');
        }
        $statement->close();
    }

    // $sql = "INSERT INTO tbl_favour (id_favour, id_user, id_person) VALUES (NULL, '$user_id', '$id_person')";

    // if (mysqli_query($con, $sql)) {
    //     echo json_encode("success");
    // } else {
    //     echo json_encode("failed");
    //     return;
    // }

?>