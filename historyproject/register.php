<?php
include('connectDB.php');

if(!$con)
{
    echo "Database connection failed";
}
 $name = $_POST['name'];
 $email = $_POST['email'];
 $password = $_POST['password'];

 $image = $_FILES['image']['name'];
 

 $imagePath = 'uploadProfile/'.$image;
 $tmp_name = $_FILES['image']['tmp_name'];

 move_uploaded_file($tmp_name, $imagePath);



 $sql = "SELECT  * FROM tbl_user WHERE email = '".$email."' AND  password = '".$password."'  AND name ='".$name."' AND img_user ='".$image."' ";
 $result = mysqli_query($con, $sql);
 $count = mysqli_num_rows($result);


 if($count == 1){
    echo json_encode("Error");
}else{
    $insert = "INSERT INTO tbl_user (name, email, password, img_user) VALUES ('".$name."','".$email."','".$password."','".$image."')";
        $query = mysqli_query($con, $insert);
    if($query){
        echo json_encode("Success");
    }
 }
?>