<?php
    include ('connectDB.php');
    if(isset($_POST['email']) && isset($_POST['password'])
    ){
        $email = $_POST['email'];
        $password = $_POST['password'];
    }
    else{
        echo json_encode("Error");
        return;
    }



    $sql = "select * from tbl_user where email = '$email' and password = '$password'";
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