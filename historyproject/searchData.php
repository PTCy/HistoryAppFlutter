<?php
 include ('connectDB.php');

 if(isset($_POST['name']) 

 ){
     $Search = $_POST['name'];

 }
 else{
     echo json_encode("Error");
     return;
 }
    if($Search == ""){
        echo json_encode("Fail");
        return;
    }
    else{
        $sql = "SELECT * FROM tbl_person WHERE name LIKE '%$Search%'";
    }
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