<?php 

    include ('connectDB.php');

    $user_id = $_POST['user_id'];


    $sql = "SELECT
    f.id_favour,f.id_user,
    p.*,
    d.name_des,d.birthday,d.description
    FROM tbl_favour f
    INNER JOIN tbl_person AS p
    ON p.id_person = f.id_person
    INNER JOIN tbl_description d
    ON d.id_des = p.id_des
    WHERE f.id_user = '$user_id'";

    $query= mysqli_query($con, $sql);
    $result = array();
    while($rs = $query->fetch_assoc()){
        $result[] = $rs;
    }

    //print_r($result);
    echo json_encode($result);

?>