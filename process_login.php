<?php
if(isset($_POST['user']) && isset($_POST['pass'])){
    //Lay thong tin tu FORM gui toi
    $user = $_POST['user'];
    $pass = $_POST['pass'];

    //KIEM TRA THONG TIN lay duoc voi CSDL
    //B1. ket noi DB Server
    try{
        $conn = new PDO("mysql:host=localhost;dbname=btth01_cse485", "root");
        //B2. thuc thi truy van
        $sql = "SELECT * FROM users WHERE (username = '$user' OR email='$user')";
        $stmt = $conn->prepare($sql);
        $stmt->execute();

        //B3. xu ly truy van
        if($stmt->rowCount() > 0){
            $row = $stmt->fetch();
            $pass_saved = $row['pass']; //Lay mat khau dang luu trong CSDL
            if(password_verify($pass, $pass_saved)){
                header("Location:admin/index.php");
            }else{
                $error = "Password invalid";
                header("Location:login.php?error=$error");
            }
        }else{
            $error = "Username not found";
            header("Location:login.php?error=$error");
        }
    }catch(PDOException $e){
        echo $e->getMessage();
    }
}