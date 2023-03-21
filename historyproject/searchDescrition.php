<?php
 include ('connectDB.php');

 if(isset($_POST['id_person']) 

 ){
     $id_person = $_POST['id_person'];

 }
 else{
     echo json_encode("Error");
     return;
 }

 $sql = "SELECT tbl_person.*,tbl_description.name_des,tbl_description.birthday,tbl_description.description
 FROM tbl_person
 INNER JOIN tbl_description
 ON tbl_person.id_des = tbl_description.id_des
 WHERE id_person = '$id_person'";

    $result = mysqli_query($con, $sql);


    if(mysqli_num_rows($result) > 0){

        while($row = mysqli_fetch_assoc($result)){
            $array[] = $row;
        }
        echo json_encode($array);
    }


    else{
        echo json_encode("Fail");
        return;
    }