<?php
//config.php
$host = '127.0.0.1';
$db = 'flutter_pustaka2_2301083011';
$user = 'root';
$pass = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);  
} catch (PDOException $e){
    die("Could not connet to the database $db :" . $e->getMessage());
}
?>