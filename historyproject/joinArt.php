<?php 

    include ('connectDB.php');

    $sql = "SELECT tbl_person.*,tbl_description.name_des,tbl_description.birthday,tbl_description.description
    FROM tbl_person
    INNER JOIN tbl_description
    ON tbl_person.id_des = tbl_description.id_des
    WHERE id_type='3'";

    $query= mysqli_query($con, $sql);
    $result = array();
    while($rs = $query->fetch_assoc()){
        $result[] = $rs;
    }
    //print_r($result);
    echo json_encode($result);

?>